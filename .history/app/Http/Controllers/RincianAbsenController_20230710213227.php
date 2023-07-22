<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id)
    $absenMatakuliah = DB::table('absenmahasiswa')
        ->join('pertemuan', 'absenmahasiswa.id_jadwal', '=', 'pertemuan.id_jadwal')
        ->select('pertemuan.tgl', 'pertemuan.hari', 'pertemuan.ruangan', 'absenmahasiswa.status')
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
