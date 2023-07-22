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

        $no_va = $kwitansi->no_va;
        $jnsPembayaran = $kwitansi->jenispembayaran;
        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,

            ],
            'list_uang_kuliah' => $daftar_uang_kuliah
        ];

        return response()->json($response, 200);
    }

}
