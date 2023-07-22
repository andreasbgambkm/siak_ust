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
        $now = date('Y-m-d H:i:s');
        date_default_timezone_set('Asia/Jakarta');
        $date = date('Y-m-d');
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();
        $idTa = $tahunAjaran->id_ta;
        $validatedData = $request->validate([
            'nmortu' => 'required|string',
            'keperluan' => 'required|string',

        ]);
        $surat = new SuratAktif();
        $surat->ID_Surat  = 'A-01';
        $surat->npm = $npm;
        $surat->Tanggal = $date;
        $surat->No_Surat = '';
        $surat->tgl_surat = $now;
        $surat->ta = $idTa;
        $surat->nmortu = $request->input('nmortu');
        $surat->keperluan = $request->input('keperluan');


        $surat->save();

        return response()->json([
            'message' =>"Surat Aktif Kuliah Berhasil diinput.Silahkan hubungi Tata Usaha!",
        ], 200);

    }

}
