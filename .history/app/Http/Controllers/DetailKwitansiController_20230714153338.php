<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DetailKwitansiController extends Controller
{
    public function show($idTA)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();

        $idTa = $tahunAjaran->id_ta;
        $getTA = $tahunAjaran->tahun_ajaran;
        $getTA2 = $getTA + 1;
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $hitungSemester = $semesterBerjalan->count();

        $daftar_uang_kuliah = DB::table('tbkwitansi')
        ->join('tbjenisbayar2', 'tbkwitansi.jenispembayaran', '=', 'tbjenisbayar2.no_jenis_bayar')
        ->join('tbbatasbayar', 'tbkwitansi.jenispembayaran', '=', 'tbbatasbayar.jns_bayar')
        ->select('tbkwitansi.no_va', 'tbjenisbayar2.nama_jenis_bayar', 'tbbatasbayar.mulai', 'tbbatasbayar.batas')
        ->where('tbkwitansi.npm', $uid)
        ->whereNotIn('tbkwitansi.status', [1])
        ->get();

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2,
            ],
            'list_uang_kuliah' => $daftar_uang_kuliah
        ];

        return response()->json($response, 200);
    }

}
