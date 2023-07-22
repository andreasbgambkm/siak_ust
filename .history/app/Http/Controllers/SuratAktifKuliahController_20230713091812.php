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


        $suratAktif = DB::table('tbsurataktifkuliah')
        ->select('tbsurataktifkuliah.NPM', 'tbsurataktifkuliah.Tanggal', 'tbsurataktifkuliah.nmortu', 'tbsurataktifkuliah.n_uts', 'tbsurataktifkuliah.keperluan')
        ->where('tbsurataktifkuliah.npm', $NPM)


        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi
            ],
            'daftar_surat' => $suratAktif
        ];

        return response()->json($response, 200);
    }
}
