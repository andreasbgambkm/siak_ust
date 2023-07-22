<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SKPembimbing;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class SKPembimbingController extends Controller
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



        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi,
            ],
        ];

        return response()->json($response, 200);
    }

    public function store(Request $request)
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

        $now = date('Y-m-d H:i:s');
        date_default_timezone_set('Asia/Jakarta');
        $date = date('Y-m-d');
        // Ambil file yang diunggah

        $lampiran = $request->file('lampiran');

        // Ubah nama file

        $namaLampiran = 'lampiranTP'.$npm . time() . '.' . $lampiran->getClientOriginalExtension();

        // Simpan file ke dalam direktori yang diinginkan

        $lampiran->storeAs('public/uploads', $namaLampiran);

        			lampiran	status	
        $surat = new SKPembimbing();
        $surat->id_surat  = 'A-013';
        $surat->npm = $npm;
        $surat->tgl_daftar = $now;
        $surat->status = '0';
        $surat->lampiran = $lampiran;

        $surat->save();

        return response()->json([
            'message' => "Surat Keterangan Pembimbing berhasil diinput. Silahkan tunggu pangilan dari Tata Usaha!",
        ], 200);
    }
}
