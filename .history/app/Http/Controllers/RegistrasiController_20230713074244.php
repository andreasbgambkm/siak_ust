<?php

namespace App\Http\Controllers;

use App\Models\Registrasi;
use App\Models\ProfileMahasiswa;
use Illuminate\Http\Request;
use App\Functions\KodeProdiFunction;
use Illuminate\Support\Facades\Cache;

class RegistrasiController extends Controller
{
    public function show()
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::where('npm', $uid)->first();
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);


        $registrasi = Registrasi::where('npm', $uid)->get();

        $response = [
            'user' => [
                'prodi' => $prodi,
                'fakultas' => $fakultas,
            ],
            'registrasi' => $registrasi
        ];

        return response()->json($response, 200);
    }
}
