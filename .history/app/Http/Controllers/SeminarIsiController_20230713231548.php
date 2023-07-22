<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SeminarIsi;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class SeminarIsiController extends Controller
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

        // Cek apakah data sudah ada, jika ada lakukan update, jika tidak lakukan create
        $surat = SeminarIsi::updateOrCreate(
            ['npm' => $npm],
            [
                'id_surat' => 'A-08',
                'tanggal' => $date,
                'tgl_daftar' => $now,
                'status' => '',
                'mhs_pem1' => '',
                'mhs_pem2' => '',
                'draft' => $namadraft,
                'lampiran' => $namaLampiran,
            ]
        );

        return response()->json([
            'message' => "Surat Seminar Isi berhasil diinput. Silahkan tunggu pangilan dari Tata Usaha!",
        ], 200);
    }
}
