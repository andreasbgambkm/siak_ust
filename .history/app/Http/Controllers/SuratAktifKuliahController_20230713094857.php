<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SuratAktif;
use App\Functions\KodeProdiFunction;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class SuratAktifKuliahController extends Controller
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

        $suratAktif = SuratAktif::where('npm', $npm)->get();


        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi
            ],
            'surat_aktif' => $suratAktif,
        ];

        return response()->json($response, 200);
    }
    public function store(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::where('npm', $uid)->first();
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $now = time();
        date_default_timezone_set('Asia/Jakarta');

        $validatedData = $request->validate([
            'nmortu' => 'required|string',
            'keperluan' => 'required|string',

        ]);
        $surat = new SuratAktif();
        $surat->ID_Surat  = 'A-01';
        $surat->npm = $npm;
        $surat->Tanggal = $request->input('name');
        $surat->No_Surat = $request->input('email');
        $surat->tgl_surat = $request->input('email');
        $surat->nmortu = $request->input('nmortu');
        $surat->keperluan = $request->input('keperluan');


        $user->save();

        return response()->json($user, 201);
    }
}
