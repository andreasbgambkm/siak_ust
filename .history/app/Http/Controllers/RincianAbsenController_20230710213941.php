<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function show($id)
    {
        $uid = auth('sanctum')->user()->id;
        $absenMatakuliah = DB::table('tbabsensimhs')
            ->join('tbabsensidosen', 'tbabsensimhs.id_jadwal', '=', 'tbabsensidosen.id_jadwal')
            ->select('tbabsensidosen.tgl', 'tbabsensidosen.hari', 'tbabsensidosen.ruangan', 'tbabsensimhs.status')
            ->where('tbabsensimhs.npm', $uid)
            ->where('tbabsensidosen.id_jadwal', $id)
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
