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

        $absensi = AbsensiDosen::where('id_jadwal', $id_jadwal)->get();
        $uid = auth('sanctum')->user()->id;
        if ($absensi->isEmpty()) {
            return response()->json([
                'message' => 'Data not found.',
            ], 404);
        }

        $details = $absensi->map(function ($item) {
            $status = substr(DB::table('tbabsensimhs')
            ->where('id_jadwal', $item->id_jadwal)
            ->where('npm', $uid)
            ->value('status'), $index, 1);
            return [
                'tgl' => $item->tgl,
                'hari' => date('l', strtotime($item->tgl)),
                'ruangan' => $item->ruangan,
                'status' => $status ?? 'N/A', // Jika tidak ada status yang ditemukan, berikan nilai 'N/A'
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
