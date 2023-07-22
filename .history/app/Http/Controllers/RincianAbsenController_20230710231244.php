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

        // Ambil semua data id_jadwal dari tabel absensidosen
        $idJadwalList = Absensidosen::pluck('id_jadwal');

        $response = [];

        // Looping berdasarkan id_jadwal
        foreach ($idJadwalList as $idJadwal) {
            // Ambil data tgl, hari, dan ruangan dari tabel absensidosen
            $absensidosen = Absensidosen::where('id_jadwal', $idJadwal)->first();
            $tgl = $absensidosen->tgl;
            $hari = $absensidosen->hari;
            $ruangan = $absensidosen->ruangan;

            // Ambil data status dari tabel absensimhs berdasarkan id_jadwal
            $status = Absensimhs::where('id_jadwal', $idJadwal)->pluck('status');

            // Buat array untuk respons
            foreach ($status as $s) {
                $response[] = [
                    "tgl" => $tgl,
                    "hari" => $hari,
                    "ruangan" => $ruangan,
                    "status" => $s,
                ];
            }

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
