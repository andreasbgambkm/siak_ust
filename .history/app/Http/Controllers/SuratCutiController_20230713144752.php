<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SuratCuti;
use App\Models\TahunAjaran;
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

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi,
                'aemester'=>$semester
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

        $validatedData = $request->validate([
            'nmortu' => 'required|string',
            'keperluan' => 'required|string',

        ]);

        $surat = new SuuatCuti();
        $surat->ID_Surat  = 'A-01';
        $surat->npm = $npm;
        $surat->Tanggal = $date;
        $surat->No_Surat = '';
        $surat->tgl_surat = $now;
        $surat->ta = $idTa;
        $surat->nmortu = $request->input('nmortu');
        $surat->keperluan = $request->input('keperluan');


        $surat->save();

        return response()->json([
            'message' =>"Surat Aktif Kuliah Berhasil diinput.Silahkan hubungi Tata Usaha!",
        ], 200);

    }
}
