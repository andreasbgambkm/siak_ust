<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SuratCuti;
use App\Models\TahunAjaran;
use App\Models\AktivitasKuliah;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class SuratCutiController extends Controller
{
    public function show()
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::where('npm', $uid)->first();
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $semester = $semesterBerjalan->count();
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();
        $idTa = $tahunAjaran->id_ta;
        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi,
                'semester'=>$semester,
                'id_ta'=>$idTa
            ],
        ];

        return response()->json($response, 200);
    }

    public function store(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::where('npm', $uid)->first();
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $now = date('Y-m-d H:i:s');
        date_default_timezone_set('Asia/Jakarta');
        $date = date('Y-m-d');
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $semester = $semesterBerjalan->count();
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();
        $idTa = $tahunAjaran->id_ta;
        $lampiran = $request->file('lampiran');

        $namaLampiran = 'lampirancuti_'.$npm . time() . '.' . $lampiran->getClientOriginalExtension();
        $validatedData = $request->validate([
            'alasan' => 'required|string',
            'alamat_ortu' => 'required|string',
            'nohp' => 'required|numeric',
            'nohportu' => 'required|numeric',
        ]);

        $lampiran->storeAs('public/uploads', $namaLampiran);

        $surat = new SuratCuti();
        $surat->id_surat  = 'A-04';
        $surat->no_surat  = '';
        $surat->npm = $npm;
        $surat->tgl_surat = $now;
        $surat->semester = $semester;
        $surat->tanggal = $date;
        $surat->ta = $idTa;
        $surat->status_pa = '0';
        $surat->tgl_pa = '';
        $surat->status_kaprodi = '0';
        $surat->tgl_kaprodi = '';
        $surat->status_dekan = '0';
        $surat->tgl_dekan = '';
        $surat->Keterangan = '';
        $surat->Keteranganpa = '';
        $surat->keterangandekan = '';
        $surat->alasan = $request->input('alasan');
        $surat->nohp = $request->input('nohp');
        $surat->alamat_ortu = $request->input('alamat_ortu');
        $surat->nohportu = $request->input('nohportu');
        $surat->lampiran = $lampiran;

        $surat->save();

        return response()->json([
            'message' =>"Surat Cuti Berhasil diinput.Silahkan hubungi Tata Usaha!",
        ], 200);

    }
}
