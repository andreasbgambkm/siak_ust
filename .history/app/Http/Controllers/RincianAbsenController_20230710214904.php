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
            ->select('tbabsensidosen.tgl', 'tbabsensidosen.ruangan', 'tbabsensimhs.status')
            ->where('tbabsensimhs.npm', $uid)
            ->where('tbabsensidosen.id_jadwal', $id)
            ->get();


        $response = [
            'matakuliah' => []
        ];

        $statusOrder = [
            'H', 'A'
        ];
        $hariIndonesia = [
            'Sunday' => 'Minggu',
            'Monday' => 'Senin',
            'Tuesday' => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday' => 'Kamis',
            'Friday' => 'Jumat',
            'Saturday' => 'Sabtu'
        ];

        foreach ($absenMatakuliah as $absen) {
            $tgl = date('d M Y', strtotime($absen->tgl));
            $hari = date('l', strtotime($absen->tgl));

            $status = substr($absen->status, -1); // Mengambil satu karakter terakhir dari string status

            // Mengubah status sesuai dengan urutan yang diinginkan
            if (in_array($status, $statusOrder)) {
                $status = $statusOrder[array_search($status, $statusOrder)];
            }

            $matakuliah = [
                'tgl' => $tgl,
                'hari' => $hari,
                'ruangan' => $absen->ruangan,
                'status' => $status
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
