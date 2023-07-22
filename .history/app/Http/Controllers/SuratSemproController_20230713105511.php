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
        $draf = $request->file('draf');
        $lampiran = $request->file('lampiran');

        // Ubah nama file
        $namaDraf = 'draftsempro_'.$npm . time() . '.' . $file1->getClientOriginalExtension();
        $namaLampiran = 'lampiransempro'.$npm . time() . '.' . $file2->getClientOriginalExtension();

        // Simpan file ke dalam direktori yang diinginkan
        $draf->storeAs('public/uploads', $namaDraf);
        $lampiran->storeAs('public/uploads', $namaLampiran);

        // Lanjutan kode Anda...
        $surat = new SuratSeminarProposal();
        $surat->file1 = $draf;
        $surat->file2 = $lampiran;

        $surat->save();

        return response()->json([
            'message' => "Surat Seminar Proposal berhasil diinput. Silahkan tunggu pangilan dari Tata Usaha!",
        ], 200);
    }


}
