<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\SuratPkl;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class SuratPklController extends Controller
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

        $suratAktif = SuratPkl::where('npm', $npm)->get();


        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'fakultas' => $fakultas,
                'prodi' => $prodi
            ],
            'surat_aktif' => $suratAktif,
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
            'pimpinan' => 'required|string',
            'pekerjaan' => 'required|string',
            'inst' => 'required|string',
            'alamat' => 'required|string',
            'jenis' => 'required|string',
            'jabatan' => 'required|string',
            'hpwa' => 'required|numeric',

        ]);
        $surat = new SuratPkl();
        $surat->id_surat  = 'A-012';
        $surat->npm = $npm;
        $surat->tanggal_daftar = $date;
        $surat->no_surat = '';
        $surat->tanggal_surat = $date;
        $surat->lokasi = '';
        $surat->status = '';
        $surat->pembimbing = '';
        $surat->jabatan = null;
        $surat->pimpinan = $request->input('pimpinan');
        $surat->hpwa = $request->input('hpwa');
        $surat->waktu = $request->input('waktu');
        $surat->pekerjaan = $request->input('pekerjaan');
        $surat->inst = $request->input('inst');
        $surat->alamat = $request->input('alamat');
        $surat->jenis = $request->input('jenis');



        $surat->save();

        return response()->json([
            'message' =>"Surat PKL/KKN/Magang Berhasil diinput.Silahkan hubungi Tata Usaha!",
        ], 200);

    }
}
