<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function index()
    {
        $absensi = AbsensiDosen::all(); // Mengambil semua data absensi dari tabel

        $response = [];

        foreach ($absensi as $absen) {
            $jadwal = [
                'tgl' => $absen->tgl,
                'hari' => date('l', strtotime($absen->tgl)),
                'ruangan' => $absen->ruangan
            ];

            $response[] = $jadwal;
        }

        return response()->json($response, 200);
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
