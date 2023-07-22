<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SuratRiset;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class SuratRisetController extends Controller
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

        $suratAktif = SuratRiset::where('npm', $npm)->first();

        $judul = $suratAktif->judul;
        $ditujukan=$suratAktif->ditujukan;
        $alamtPenelitian =$suratAktif->alamat_penelitian;

        if (!$suratAktif) {
            return response()->json([
                'message' => 'Data not found.',
                'status' => 'false',
            ], 404);
        }
        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi,
                'ditujukan'=>$ditujukan,
                'alamat_penelitian'=>$alamat_penelitian,
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
        $validatedData = $request->validate([
            'alamat_peneliatian' => 'required|string',
            'tempat_penelitian' => 'required|string',
            'judul' => 'required|string',

        ]);

        $surat = new SuratRiset();
        $surat->id_surat  = 'A-03';
        $surat->npm = $npm;
        $surat->tanggal = $date;
        $surat->no_surat = '';
        $surat->$ditujukan = '';
        $surat->judul = $request->input('judul');
        $surat->tempat_penelitian = $request->input('tempat_penelitian');
        $surat->alamat_peneliatian = $request->input('alamat_peneliatian');
        $surat->save();

        return response()->json([
            'message' =>"Surat Aktif Riset Berhasil diinput.Silahkan hubungi Tata Usaha!",
        ], 200);

    }
}
