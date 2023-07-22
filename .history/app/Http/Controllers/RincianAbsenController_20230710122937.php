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
        $matakuliah = [];

        $pertemuanData = AbsensiDosen::all();

        foreach ($pertemuanData as $pertemuan) {
            $absenMahasiswa = AbsensiMahasiswa::where('id_jadwal', $pertemuan->id_jadwal)->first();
            
            $matakuliah[] = [
                "tgl" => $pertemuan->tgl,
                "hari" => $this->getHari($pertemuan->tgl),
                "ruangan" => $pertemuan->ruangan,
                "status" => $absenMahasiswa ? $absenMahasiswa->status : "",
            ];
        }

        return response()->json([
            "matakuliah" => $matakuliah,
        ]);
    }

    private function getHari($tanggal)
    {
        $hari = date('l', strtotime($tanggal));
        $hariList = [
            'Sunday' => 'Minggu',
            'Monday' => 'Senin',
            'Tuesday' => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday' => 'Kamis',
            'Friday' => 'Jumat',
            'Saturday' => 'Sabtu',
        ];

        return $hariList[$hari];
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
}
