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

        if ($absensi->isEmpty()) {
            return response()->json([
                'message' => 'Data not found.',
            ], 404);
        }

        $details = $absensi->map(function ($item, $index) {
            $uid = auth('sanctum')->user()->id;
            $status = substr(DB::table('tbabsensimhs')
                ->where('id_jadwal', $item->id_jadwal)
                ->where('npm', $uid)
                ->value('status'), $index, 1);

            $hari = strftime("%A", strtotime($item->tgl));
            $hariIndonesia = $this->convertToIndonesianDay($hari);

            return [
                'tgl' => $item->tgl,
                'hari' => $hariIndonesia,
                'ruangan' => $item->ruangan,
                'status' => $status ?? 'N/A', // Jika tidak ada status yang ditemukan, berikan nilai 'N/A'
            ];
        });

        return response()->json($details, 200);
    }

    private function convertToIndonesianDay($day)
    {
        $dayNames = [
            'Sunday' => 'Minggu',
            'Monday' => 'Senin',
            'Tuesday' => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday' => 'Kamis',
            'Friday' => 'Jumat',
            'Saturday' => 'Sabtu',
        ];

        return $dayNames[$day] ?? $day;
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
