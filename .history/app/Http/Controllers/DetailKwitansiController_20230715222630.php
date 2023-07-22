<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DetailKwitansiController extends Controller
{
    public function show($kdkwitansi)
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

        $kwitansi = Kwitansi::where('kdkwitansi', $kdkwitansi)
        ->whereNotIn('tbkwitansi.status', [1])
        ->get();

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,

            ],
            'detail_uang_kuliah' => $kwitansi
        ];

        return response()->json($response, 200);
    }

}
