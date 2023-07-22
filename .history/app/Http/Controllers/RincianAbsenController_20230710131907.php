<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id)
    {
        $matakuliah = DB::table('tbabsensidosen')
            ->leftJoin('tbabsensimhs', 'tbabsensidosen.id_jadwal', '=', 'tbabsensimhs.id_jadwal')
            ->select('tbabsensidosen.tgl', 'tbabsensidosen.hari', 'tbabsensidosen.ruangan', 'tbabsensimhs.status')
            ->where('tbabsensidosen.id_jadwal', $id)
            ->get();

        $response = [
            'matakuliah' => $matakuliah,
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
