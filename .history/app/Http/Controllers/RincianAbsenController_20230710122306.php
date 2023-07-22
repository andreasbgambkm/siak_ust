<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id)
    {
        $absenmahasiswa = DB::table('absenmahasiswa')
            ->select('tgl', 'hari', 'ruangan', 'status')
            ->where('id_jadwal', $id)
            ->whereIn('status', ['H', 'I', 'A', 'S'])
            ->get();

        $response = [
            'matakuliah' => $absenmahasiswa
        ];

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
}
