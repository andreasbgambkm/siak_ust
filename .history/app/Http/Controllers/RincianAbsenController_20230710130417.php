<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\AbsensiDosen;
use App\Models\AbsensiMahasiswa;
use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    class MatakuliahController extends Controller
    {
        public function show($id)
        {
            $matakuliah = DB::table('pertemuan')
                ->leftJoin('absenmahasiswa', 'pertemuan.id_jadwal', '=', 'absenmahasiswa.id_jadwal')
                ->select('pertemuan.tgl', 'pertemuan.hari', 'pertemuan.ruangan', 'absenmahasiswa.status')
                ->where('pertemuan.id_jadwal', $id)
                ->get();
    
            $response = [
                'matakuliah' => $matakuliah,
            ];
    
            return response()->json($response);
        }
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
