<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Cache;
use App\Models\ProfileMahasiswa;
use Illuminate\Http\Request;
use App\Functions\KodeProdiFunction;


use App\Functions\ProfileFunction;

class ProfileMahasiswaController extends Controller
{
    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;

        // Mengecek apakah data profil mahasiswa sudah ada di cache
        $cacheKey = 'profile_' . $uid;
        if (Cache::has($cacheKey)) {
            // Mengembalikan data dari cache
            return Cache::get($cacheKey);
        }

        // Jika data profil mahasiswa belum ada di cache, ambil dari database
        $profile = ProfileMahasiswa::where('npm', $uid)->first();

        $npm =$profile->npm;
        $nama=$profile->nm_mhs;
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $tmpt_lahir=$profile->tmpt_lahir;
        $tgl_lahir=$profile->tgl_lahir;
        $jenisKelamin=$profile->jk;
        $kode = new ProfileFunction();
        $jk = $kode->jenisKelamin($jenisKelamin);
        $kdagama=$profile->agama;
        $agama = $kode->agama($kdagama);
        $provinsi=$profile->provinsi;
        $kota=$profile->kota;
        $kabupaten=$profile->kabupaten;
        $kecamatan=$profile->kecamatan;
        $kel_mhs=$profile->kel_mhs;
        $rt_mhs=$profile->rt_mhs;
        $rw_mhs=$profile->rw_mhs;
        $nm_ayah=$profile->nm_ayah;
        $nm_ibu=$profile->nm_ibu;
        $alamat_ortu=$profile->alamat_ortu;
        $pekerjaan_ayah=$profile->pekerjaan_ayah;
        $pekerjaan_ibu=$profile->pekerjaan_ibu;

        $data = [
            'npm' => $npm,
            'nama' => $nama,
            'prodi' => $prodi,
            'fakultas' => $fakultas,
            'tgl_lahir' => $tgl_lahir,
            'jk' => $jk,
            'agama' => $agama,
            'provinsi' => $provinsi,
            'kota' => $kota,
            'kabupaten' => $kabupaten,
            'kecamatan' => $kecamatan,
            'kel_mhs' => $kel_mhs,
            'rt_mhs' => $rt_mhs,
            'rw_mhs' => $rw_mhs,
            'nm_ayah' => $nm_ayah,
            'nm_ibu' => $nm_ibu,
            'alamat_ortu' => $alamat_ortu,
            'pekerjaan_ayah' => $pekerjaan_ayah,
            'pekerjaan_ibu' => $pekerjaan_ibu
        ];

        // Menyimpan data profil mahasiswa ke cache
        Cache::put($cacheKey, $data, 360); // Simpan dalam cache selama 1 jam (3600 detik)

        return $data;
    }
}
