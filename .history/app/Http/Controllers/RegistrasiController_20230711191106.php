<?php

namespace App\Http\Controllers;

use App\Models\Registrasi;
use App\Models\ProfileMahasiswa;
use Illuminate\Http\Request;
use App\Functions\KodeProdiFunction;
use Illuminate\Support\Facades\Cache;

class RegistrasiController extends Controller
{
    public function show(Request $request)
    {

        $profile = ProfileMahasiswa::where('npm', $uid)->first();
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $uid = auth('sanctum')->user()->id;
        $registrasi = Registrasi::where('npm', $uid)->get();

        $response = [
            'user' => [
                'prodi' => $npm,
                'fakultas' => $nama,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2,
                'kode_matakuliah' => $kodeMatakuliah,
                'nama_matakuliah' => $namaMatakuliah
            ],
            'registrasi' => $registrasi
        ];

        return response()->json($response, 200);
    }
}
