<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\JadwalKRS;
use App\Functions\KodeProdiFunction;
use App\Models\TahunAjaran;
use Illuminate\Support\Facades\DB;
use App\Models\ProfileMahasiswa;
use App\Models\KRS;
use App\Models\DetailKRS;
use App\Models\AktivitasKuliah;
use App\Models\Kwitansi;
use App\Models\BayanganKRS;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Validator;

class IsiKRSController extends Controller
{
    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $kdprodi = $profile->kd_prodi;
        $kdfakultas = $profile->fakultas;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();

        $idTa = $tahunAjaran->id_ta;
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $hitungSemester = $semesterBerjalan->count();

        $ipSemestersSebelum = DB::table('tbaktivitaskuliah')
        ->where('npm', $uid)
        ->where('thn_ajaran', 'NOT LIKE', '%3')
        ->orderBy('thn_ajaran', 'desc')
        ->skip(1) // Melewatkan baris pertama (nilai thn_ajaran paling baru)
        ->first();

        $ip = $ipSemestersSebelum->ip;
        if ($ip >= 3) {
            $maksSKS = 24;
        } elseif ($ip >= 2.5) {
            $maksSKS = 22;
        } elseif ($ip >= 2) {
            $maksSKS = 20;
        } else {
            $maksSKS = 18;
        }
        $maksimal_sks = $maksSKS;


        if (!$tahunAjaran) {
            return response()->json(['message' => 'Tahun ajaran tidak ditemukan'], 404);
        }
        $npm = auth('sanctum')->user()->id;
        $cek_status_krs = Kwitansi::where('npm', $npm)
            ->where('ta', $idTa)
            ->where('status', '1')
            ->count();



        $jadwal_krs = JadwalKRS::where('thn_ajaran', $idTa)
        ->get();

        $krs = KRS::where('npm', $npm)->first();
        $idKrs = $krs->id_krs;

        $kelasUser = DetailKRS::where('id_krs', $idKrs)->first();
        $kelas = $kelasUser->kelas;

        $krs_sesuai_semester = JadwalKRS::where('thn_ajaran', $idTa)
        ->where('semester', $hitungSemester)
        ->where('kelas', $kelas)
        ->pluck('id');

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,
                'semester_berjalan' => $hitungSemester,
                'ipsemestersebelum' => $ip,
                'maks_SKS' => $maksimal_sks,
            ],

        ];
        if ($cek_status_krs == 0) {
            $response['message'] = 'Anda belum dapat mengisi KRS. Silahkan membayar UKP terlebih dahulu!';
        } else {
            $response['jadwal_krs'] = $jadwal_krs;
            $response['krs_sesuai'] = $krs_sesuai_semester;
        }
        return response()->json($response);
    }

    public function store(Request $request)
    {
        // Validasi data yang diterima dari pengguna
        $validatedData = $request->validate([
            'id_jadwal' => 'required|array',
            'id_jadwal.*' => 'exists:jadwallengkap,id',

        ]);
        $uid = auth('sanctum')->user()->id;
        $idJadwal = $validatedData['id_jadwal'];
        $ipSemestersSebelum =DB::table('tbaktivitaskuliah')
        ->where('npm', $uid)
        ->where('thn_ajaran', 'NOT LIKE', '%3')
        ->orderBy('thn_ajaran', 'desc')
        ->first();
        $ip = $ipSemestersSebelum->ip;
        if ($ip >= 3) {
            $maksSKS = 24;
        } elseif ($ip >= 2.5) {
            $maksSKS = 22;
        } elseif ($ip >= 2) {
            $maksSKS = 20;
        } else {
            $maksSKS = 18;
        }
        $maksimal_sks = $maksSKS;

        $totalSks = JadwalKRS::whereIn('id', $idJadwal)->sum('sks');
        if ($totalSks > $maksSKS) {
            throw ValidationException::withMessages([
                'id_jadwal' => 'Total SKS melebihi batas maksimal.',
            ]);
        }

        $semesterBerjalan = DB::table('tbaktivitaskuliah')
        ->where('npm', $uid)
        ->where('thn_ajaran', 'NOT LIKE', '%3')
        ->get();
        $hitungSemester = $semesterBerjalan->count();

        $get_kelas = JadwalKRS::whereIn('id', $idJadwal)->pluck('kelas');
        $kelas = $get_kelas->toArray();
        // Simpan pilihan jadwal ke dalam database
        try {
            foreach ($validatedData['id_jadwal'] as $jadwalId) {
                $krs = new BayanganKRS();
                $krs->id_jadwal = $jadwalId;
                $krs->id_krs = $hitungSemester . $uid;
                $krs->status = '0';
                $krs->save();
            }
        } catch (\PDOException $e) {
            if ($e->getCode() === '23000') {
                throw ValidationException::withMessages([
                    'id_jadwal' => 'Duplikasi ID Jadwal.',
                ]);
            } else {
                throw $e;
            }
        }


        // Response sukses
        return response()->json(['message' => 'KRS berhasil diinput'], 201);
    }
    public function destroy($id)
    {
        $uid = auth('sanctum')->user()->id;
        $getidKrs = KRS::where('npm', $uid)->first();
        $idKrs = $getidKrs->id_krs;
        $krs = BayanganKRS::where('id_jadwal', $id)
        ->where('id_krs', $idKrs)
        ->whereNotIn('tbkwitansi.status', [1])
        ->first();

        if (!$krs) {
            return response()->json(['message' => 'Buku tidak ditemukan'], 404);
        }

        $krs->delete();

        return response()->json(['message' => 'Buku berhasil dihapus'], 200);
    }
}
