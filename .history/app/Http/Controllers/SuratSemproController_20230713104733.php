<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SuratSeminarProposal;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class SuratSemproController extends Controller
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
        $judulSkripsi= $profile->judul_skripsi;


        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi,
                'judul_skripsi' => $judulSkripsi
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
        $judulSkripsi = $profile->judul_skripsi;

        // Ambil file yang diunggah
        $file1 = $request->file('file1');
        $file2 = $request->file('file2');

        // Ubah nama file
        $namaFile1 = 'draftsempro_' . time() . '.' . $file1->getClientOriginalExtension();
        $namaFile2 = 'file2_' . time() . '.' . $file2->getClientOriginalExtension();

        // Simpan file ke dalam direktori yang diinginkan
        $file1->storeAs('public/direktori', $namaFile1);
        $file2->storeAs('public/direktori', $namaFile2);

        // Lanjutan kode Anda...

        $surat->save();

        return response()->json([
            'message' => "Surat Seminar Proposal berhasil diinput. Silahkan tunggu pangilan dari Tata Usaha!",
        ], 200);
    }


}
