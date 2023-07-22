<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id)
    $absenMatakuliah = DB::table('tbabsensimhs')
        ->join('tbabsensimhs', 'tbabsensimhs.id_jadwal', '=', 'tbabsensimhs.id_jadwal')
        ->select('tbabsensimhs.tgl', 'tbabsensimhs.hari', 'tbabsensimhs.ruangan', 'tbabsensimhs.status')
        ->get();

    $response = [
        'matakuliah' => []
    ];

    foreach ($absenMatakuliah as $absen) {
        $matakuliah = [
            'tgl' => $absen->tgl,
            'hari' => $absen->hari,
            'ruangan' => $absen->ruangan,
            'status' => $absen->status
        ];

        array_push($response['matakuliah'], $matakuliah);
    }

    return response()->json($response);
}

// public function store(Request $request, $idJadwal)
// {
//     $request->validate([
//         'status' => 'required|in:H,A,I,S',
//     ]);
//     //dangsae
//     $status = $absenMahasiswa->status . $request->status;
//     $absenMahasiswa->update(['status' => $status]);
//     return response()->json(['message' => 'Status updated successfully'], 200);
// }
