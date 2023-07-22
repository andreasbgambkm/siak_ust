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
        $now = date('Y-m-d H:i:s');
        date_default_timezone_set('Asia/Jakarta');
        // Ambil file yang diunggah
        $draft = $request->file('draft');
        $lampiran = $request->file('lampiran');

        // Ubah nama file
        $namadraft = 'draftsempro_'.$npm . time() . '.' . $file1->getClientOriginalExtension();
        $namaLampiran = 'lampiransempro'.$npm . time() . '.' . $file2->getClientOriginalExtension();

        // Simpan file ke dalam direktori yang diinginkan
        $draft->storeAs('public/uploads', $namadraft);
        $lampiran->storeAs('public/uploads', $namaLampiran);

        // Lanjutan kode Anda...
        $surat = new SuratSeminarProposal();
        $surat->id_surat  = 'A-02';
        $surat->npm = $npm;
        $surat->tanggal = $date;
        $surat->tanggalx = '';
        $surat->no_surat = '';
        $surat->judul =  $judulSkripsi;
        $surat->waktu = '';
        $surat->hari = '';
        $surat->tgl_daftar = $now;
        $surat->draft = $draft;
        $surat->lampiran = $lampiran;

        $surat->save();

        return response()->json([
            'message' => "Surat Seminar Proposal berhasil diinput. Silahkan tunggu pangilan dari Tata Usaha!",
        ], 200);
    }


}
