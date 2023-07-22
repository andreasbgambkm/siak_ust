<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\TahunAjaran;
use App\Models\AktivitasKuliah;
use App\Models\JadwalKRS;
use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use App\Functions\KodeProdiFunction;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id_jadwal)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();

        $idTa = $tahunAjaran->id_ta;
        $getTA = $tahunAjaran->tahun_ajaran;
        $getTA2 = $getTA + 1;
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $hitungSemester = $semesterBerjalan->count();
        $matakuliah = JadwalKRS::where('id', $id_jadwal)->first();
        $kodeMatakuliah = $matakuliah->kd_matkul;
        $namaMatakuliah = $matakuliah->nm_matkul;

        $absensi = AbsensiDosen::where('id_jadwal', $id_jadwal)->get();

        if ($absensi->isEmpty()) {
            return response()->json([
                'message' => 'Data not found.',
            ], 404);
        }

        $absensiDetails = $absensi->map(function ($item, $index) {
            $uid = auth('sanctum')->user()->id;
            $status = substr(DB::table('tbabsensimhs')
                ->where('id_jadwal', $item->id_jadwal)
                ->where('npm', $uid)
                ->value('status'), $index, 1);

            $hari = strftime("%A", strtotime($item->tgl));
            $hariIndonesia = $this->convertToIndonesianDay($hari);

            return [
                'tgl' => $item->tgl,
                'hari' => $hariIndonesia,
                'ruangan' => $item->ruangan,
                'status' => $status ?? 'N/A', // Jika tidak ada status yang ditemukan, berikan nilai 'N/A'
            ];
        });

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2,
                'kode_matakuliah' => $kodeMatakuliah,
                'nama_matakuliah' => $namaMatakuliah
            ],
            'absensi' => $absensiDetails
        ];

        return response()->json($response, 200);
    }

    private function convertToIndonesianDay($day)
    {
        $dayNames = [
            'Sunday' => 'Minggu',
            'Monday' => 'Senin',
            'Tuesday' => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday' => 'Kamis',
            'Friday' => 'Jumat',
            'Saturday' => 'Sabtu',
        ];

        return $dayNames[$day] ?? $day;
    }

    public function store(Request $request, $id_jadwal)
    {
        $tglSekarang = Carbon::now();
        $batasWaktuAbsen = Carbon::now()->addMinutes(25);

        $absensiDosen = AbsensiDosen::where('id_jadwal', $id_jadwal)
        ->orderByDesc('pertemuan')
        ->first();


        if (!$absensiDosen) {
            return response()->json([
                'message' => 'Data not found.',
            ], 404);
        }

        if ($absensiDosen->tgl > $tglSekarang) {
            return response()->json([
                'message' => 'Absensi belum dimulai.',
            ], 400);
        }

        if ($tglSekarang > $batasWaktuAbsen) {
            return response()->json([
                'message' => 'Batas waktu absen telah berakhir.',
            ], 400);
        }

        $npm = auth('sanctum')->user()->id;
        $status = $request->input('status');

        if (!$npm || !$status) {
            return response()->json([
                'message' => 'Invalid request.',
            ], 400);
        }

        $absensiMhs = AbsensiMahasiswa::where('id_jadwal', $id_jadwal)->where('npm', $npm)->first();
        $statusSebelum =  $absensiMhs->status;

        if ($absensiMhs) {
            $pertemuanAbsensiDosen = $absensiDosen->pertemuan;
            $jumlahStatusAbsensiMhs = strlen($absensiMhs->status);

            if ($jumlahStatusAbsensiMhs >= $pertemuanAbsensiDosen) {
                return response()->json([
                    'message' => 'Absensi sudah mencapai jumlah pertemuan maksimal.',
                ], 400);
            }
        }

        if ($status === 'H' || $status === 'I' || $status === 'A' || $status === 'S') {
            $statusSesudah= $statusSebelum.$status;
            $statusSesudah->save();

            return response()->json([
                'message' => 'Absensi berhasil.',
            ], 200);
        }

        return response()->json([
            'message' => 'Status absensi tidak valid.',
        ], 400);
    }

}

// public function store(Request $request, $idJadwal)
// {
//     $request->validate([
//         'status' => 'required|in:H,A,I,S',
//     ]);
//     //dangsae
//     $status = $absenMahasiswa->status . $request->status;
//     $absenMahasiswa->update(['status' => $status]);
//     return response()->json(['message' => 'Status updated successfully'], 200);
// }
