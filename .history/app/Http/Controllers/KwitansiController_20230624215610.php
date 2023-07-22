<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Kwitansi;

class KwitansiController extends Controller
{
    public function show()
    {
        $uid = auth('sanctum')->user()->id;

        $daftar_uang_kuliah = DB::table('tbkwitansi')
        ->join('tbjenisbayar2', 'tbkwitansi.jenispembayaran', '=', 'tbjenisbayar2.no_jenis_bayar')
        ->join('tbbatasbayar', 'tbkwitansi.jenispembayaran', '=', 'tbbatasbayar.jns_bayar')
        ->select('tbkwitansi.no_va', 'tbjenisbayar2.nama_jenis_bayar', 'tbbatasbayar.mulai', 'tbbatasbayar.batas')
        ->where('tbkwitansi.npm', $uid)
        ->get();

        return response()->json($daftar_uang_kuliah);
    }
}
