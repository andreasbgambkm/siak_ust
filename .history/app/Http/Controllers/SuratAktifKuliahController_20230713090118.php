<?php

namespace App\Http\Controllers;

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


        $surat = JenisSurat::all();

        $response = [
            'user' => [
                'prodi' => $prodi,
                'fakultas' => $fakultas,
            ],
            'daftar_surat' => $surat
        ];

        return response()->json($response, 200);
    }
}
