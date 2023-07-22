<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pengumuman;

class DetailPengumuman extends Controller
{
    public function show()
    {
        $pengumuman = Pengumuman::all();
        $profile = ProfileMahasiswa::findOrFail($uid);
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2
            ],
            'matakuliah' => array_values($absensiByMatkul)
        ];

        return response()->json($response);
    }
}
