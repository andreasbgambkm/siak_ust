<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Kwitansi;

class KwitansiController extends Controller
{
    public function show()
    {
        $uid = auth('sanctum')->user()->id;
        $jadwalKRS = DB::table('tbkwitansi')
        ->join('tbjenisbayar2', 'tbkwitansi.jenispembayaran', '=', 'tbjenisbayar2.no_jenis_bayar')
        ->join('jadwallengkap', 'tbbayangandetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.kategori', 'jadwallengkap.sks', 'jadwallengkap.kelas', 'jadwallengkap.hari', 'jadwallengkap.kd_jam', 'jadwallengkap.dosen')
        ->where('tbkrs.thn_ajaran', $id)
        ->where('tbkrs.npm', $uid)
        ->get();


    }
}
