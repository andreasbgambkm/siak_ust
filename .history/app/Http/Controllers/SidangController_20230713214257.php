<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class SidangController extends Controller
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

        $now = date('Y-m-d H:i:s');
        date_default_timezone_set('Asia/Jakarta');
        $date = date('Y-m-d');
        // Ambil file yang diunggah
        $draft = $request->file('draft');
        $lampiran = $request->file('lampiran');

        // Ubah nama file
        $namadraft = 'draftTP_'.$npm . time() . '.' . $draft->getClientOriginalExtension();
        $namaLampiran = 'lampiranTP'.$npm . time() . '.' . $lampiran->getClientOriginalExtension();

        // Simpan file ke dalam direktori yang diinginkan
        $draft->storeAs('public/uploads', $namadraft);
        $lampiran->storeAs('public/uploads', $namaLampiran);


        $surat = new SeminarIsi();
        $surat->id_surat  = 'A-08';
        $surat->npm = $npm;
        $surat->tanggal2 = '';
        $surat->waktu = '';
        $surat->no_surat = '';
        $surat->hari = '';
        $surat->tanggal = $date;
        $surat->tgl_daftar = $now;
        $surat->status = '0';
        $surat->mhs_pem1 = '0';
        $surat->mhs_pem2 = '0';
        $surat->draft = $draft;
        $surat->lampiran = $lampiran;

        $surat->save();

        return response()->json([
            'message' => "Surat Sidang berhasil diinput. Silahkan tunggu pangilan dari Tata Usaha!",
        ], 200);
    }
}
