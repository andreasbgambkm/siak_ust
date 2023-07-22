<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id_jadwal)
    {
        $absenDosen = AbsenDosen::where('id_jadwal', $id_jadwal)->get();
        $detailAbsen = [];

        foreach ($absenDosen as $absen) {
            $absenMhs = AbsenMhs::where('id_jadwal', $absen->id_jadwal)->first();

            $detailAbsen[] = [
                'tgl' => $absen->tgl,
                'hari' => $absen->hari,
                'ruangan' => $absen->ruangan,
                'status' => $absenMhs->status,
            ];
        }

        return response()->json($detailAbsen);
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
