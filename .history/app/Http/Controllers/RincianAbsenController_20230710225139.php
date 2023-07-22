<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id_jadwal)
    {
        $absensiDosen = AbsensiDosen::where('id_jadwal', $id_jadwal)->first();
        $absensiMhs = AbsensiMahasiswa::where('id_jadwal', $id_jadwal)->first();

        $response = [
            'tgl' => $absensiDosen->tgl,
            'hari' => $absensiDosen->hari,
            'ruangan' => $absensiDosen->ruangan,
            'status' => $absensiMhs->status[0] // Mengambil 1 huruf dari status tbabsensidosen
        ];

        return response()->json($response);

    }
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
