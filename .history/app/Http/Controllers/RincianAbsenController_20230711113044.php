<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function index($id_jadwal)
    {
        $absensi = AbsensiDosen::where('id_jadwal', $id_jadwal)->get();

        if ($absensi->isEmpty()) {
            return response()->json([
                'message' => 'Data not found.',
            ], 404);
        }

        $details = $absensi->map(function ($item) {
            return [
                'tgl' => $item->tgl,
                'hari' => date('l', strtotime($item->tgl)),
                'ruangan' => $item->ruangan,
            ];
        });

        return response()->json($details, 200);
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
