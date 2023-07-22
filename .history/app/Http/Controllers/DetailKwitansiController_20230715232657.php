<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\AktivitasKuliah;
use Illuminate\Http\Request;
use App\Models\Kwitansi;
use App\Models\JenisBayar;
use App\Functions\KodeProdiFunction;

class DetailKwitansiController extends Controller
{
    public function show($kdkwitansi)
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

        $kwitansi = Kwitansi::where('kdkwitansi', $kdkwitansi)
        ->whereNotIn('tbkwitansi.status', [1])
        ->first();

        if (!$absensiDosen) {
            return response()->json([
                'message' => 'kwitansi tidak ada',
            ], 404);
        }
        $kdkwitansi = $kwitansi->kdkwitansi;
        $no_va = $kwitansi->no_va;
        $kdjenisbayar = $kwitansi->jenispembayaran;
        $jenisbayar = JenisBayar::findOrFail($kdjenisbayar);
        $namaJenisBayar= $jenisbayar->nama_jenis_bayar;
        $kat_a = $kwitansi->kat_a;
        $kat_b = $kwitansi->kat_b;
        $kat_c = $kwitansi->kat_c;
        $kat_d = $kwitansi->kat_d;
        $diskon = $kwitansi->diskon;
        $denda = $kwitansi->kdkwitansi;
        $jlh_bayar = $kwitansi->jlh_bayar;
        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,

            ],
            'detail_uang_kuliah' => [
                'kdkwitansi' => $npm,
                'no_virtual_akun' => $no_va,
                'jenispembayaran' => $namaJenisBayar,
                'kat_a' => $kat_a,
                'kat_b' => $kat_b,
                'kat_c' => $kat_c,
                'kat_d' => $kat_d,
                'diskon' => $diskon,
                'denda' => $denda,
                'jlh_bayar' => $jlh_bayar,

            ]
        ];

        return response()->json($response, 200);
    }

}
