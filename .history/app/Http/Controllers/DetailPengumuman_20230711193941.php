<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pengumuman;
use App\Models\ProfileMahasiswa;
use App\Functions\KodeProdiFunction;

class DetailPengumuman extends Controller
{
    public function show()
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $pengumuman = Pengumuman::all();

        $response = [
            'user' => [

                'prodi' => $prodi,
                'fakultas' => $fakultas,

            ],
            'matakuliah' => $pengumuman
        ];

        return response()->json($response);
    }
}
