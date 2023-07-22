<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show(Request $request, $id_jadwal)
    {
        $absenDosen = AbsensiDosen::where('id_jadwal', $id_jadwal)->first();
        $absenMhs = AbsensiMahasiswa::where('id_jadwal', $id_jadwal)->get();

        $response = [];

        // Ambil data dari tbabsensidosen
        $response['tgl'] = $absenDosen->tgl;
        $response['hari'] = $absenDosen->hari;
        $response['ruangan'] = $absenDosen->ruangan;

        // Ambil data dari tbabsensimhs
        foreach ($absenMhs as $absen) {
            $response['status'] = $absen->status;
        }

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
