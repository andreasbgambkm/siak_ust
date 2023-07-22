<?php

namespace App\Http\Controllers;

use App\Models\JenisSurat;
use App\Models\ProfileMahasiswa;
use Illuminate\Http\Request;
use App\Functions\KodeProdiFunction;

class SuratController extends Controller
{
    public function daftarsurat()
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::where('npm', $uid)->first();
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
