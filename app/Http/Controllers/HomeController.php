<?php

namespace App\Http\Controllers;

use App\Functions\KodeProdiFunction;
use App\Traits\HttpResponses;
use Illuminate\Support\Facades\Cache;
use App\Models\ProfileMahasiswa;
use Illuminate\Http\Request;
use App\Models\Pengumuman;

class HomeController extends Controller
{
    use HttpResponses;

    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;

        // Cek apakah data tersimpan dalam cache
        $cacheKey = 'home_data_' . $uid;
        $response = Cache::remember($cacheKey, 86.400, function () use ($uid) {
            $result = ProfileMahasiswa::findOrFail($uid);
            $npm = $result->npm;
            $nama = $result->nm_mhs;
            $foto = $result->Foto;
            $kdfakultas = $result->fakultas;
            $kdprodi = $result->kd_prodi;
            $kode = new KodeProdiFunction();
            $prodi = $kode->prodi($kdprodi);
            $fakultas = $kode->fakultas($kdfakultas);
            $pengumuman = Pengumuman::all();

            return [
                'user' => [
                    'npm' => $npm,
                    'nama' => $nama,
                    'prodi' => $prodi,

                    'fakultas' => $fakultas,
                    'foto' => 'http://siak.ust.ac.id/simak/stuu/foto/mahasiswa/'.$foto,
                ],
                'pengumuman' => $pengumuman,
            ];
        });

        return response()->json($response);
    }
}
