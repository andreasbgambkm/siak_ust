<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\TahunAjaran;
use App\Models\AktivitasKuliah;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class AbsensiController extends Controller
{
    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();

        $idTa = $tahunAjaran->id_ta;
        $getTA = $tahunAjaran->tahun_ajaran;
        $getTA2 = $getTA + 1;
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $hitungSemester = $semesterBerjalan->count();

        $absensiMahasiswa = DB::table('tbkrs')
    ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
    ->join('tbbayangandetailkrs', 'tbkrs.id_krs', '=', 'tbbayangandetailkrs.id_krs')
    ->join('tbabsensimhs', 'tbbayangandetailkrs.id_jadwal', '=', 'tbabsensimhs.id_jadwal')
    ->join('jadwallengkap', 'tbbayangandetailkrs.id_jadwal', '=', 'jadwallengkap.id')
    ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'tbabsensimhs.status')
    ->where('tbkrs.npm', $uid)
    ->where('tbtahun_ajaran.id_ta', $idTa)
    ->get();

        $absensiByMatkul = [];

        foreach ($absensiMahasiswa as $absensi) {
            $kdMatkul = $absensi->kd_matkul;
            $nmMatkul = $absensi->nm_matkul;
            $status = $absensi->status;

            // Menghitung jumlah status
            $statusCount = [
                'alpha' => 0,
                'ijin' => 0,
                'sakit' => 0,
                'hadir' => 0
            ];

            for ($i = 0; $i < strlen($status); $i++) {
                $char = strtoupper($status[$i]);
                switch ($char) {
                    case 'A':
                        $statusCount['alpha']++;
                        break;
                    case 'H':
                        $statusCount['hadir']++;
                        break;
                    case 'I':
                        $statusCount['ijin']++;
                        break;
                    case 'S':
                        $statusCount['sakit']++;
                        break;
                }
            }

            // Menghitung presentase
            $totalStatus = array_sum($statusCount);
            $alphaCount = $statusCount['alpha'];
            $presentase = ($totalStatus - $alphaCount) / $totalStatus * 100;

            // Menambahkan data absensi dan presentase ke dalam array absensiByMatkul
            if (!isset($absensiByMatkul[$kdMatkul])) {
                $absensiByMatkul[$kdMatkul] = [
                    'kd_matkul' => $kdMatkul,
                    'nm_matkul' => $nmMatkul,
                    'absensi' => $statusCount,
                    'presentase' => number_format($presentase, 2)
                ];
            } else {
                // Jika mata kuliah sudah ada dalam array, tambahkan jumlah statusnya
                $absensiByMatkul[$kdMatkul]['absensi']['alpha'] += $statusCount['alpha'];
                $absensiByMatkul[$kdMatkul]['absensi']['ijin'] += $statusCount['ijin'];
                $absensiByMatkul[$kdMatkul]['absensi']['sakit'] += $statusCount['sakit'];
                $absensiByMatkul[$kdMatkul]['absensi']['hadir'] += $statusCount['hadir'];
            }
        }

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2
            ],
            'matakuliah' => array_values($absensiByMatkul)
        ];
        return response()->json($response);
    }
}
