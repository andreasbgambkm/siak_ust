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
        ->where('tbabsensimhs.npm', $uid)
        ->get();

        $statusCount = [
            'alpha' => 0,
            'ijin' => 0,
            'sakit' => 0,
            'hadir' => 0
        ];

        foreach ($absensiMahasiswa as $absensi) {
            for ($i = 0; $i < strlen($absensi->status); $i++) {
                $char = strtoupper($absensi->status[$i]);
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
        }

        $totalStatus = array_sum($statusCount);
        $alphaCount = $statusCount['alpha'];
        $presentase = ($totalStatus - $alphaCount) / $totalStatus * 100;

        $presentaseFormatted = number_format($presentase, 2);

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2
            ],
            'absensi' => [
                'kd_matkul' => $absensiMahasiswa[0]->kd_matkul,
                'nm_matkul' => $absensiMahasiswa[0]->nm_matkul,
                'absensi' => [
                    'alpha' => $statusCount['alpha'],
                    'ijin' => $statusCount['ijin'],
                    'sakit' => $statusCount['sakit'],
                    'hadir' => $statusCount['hadir'],
                    'presentase' => $presentaseFormatted
                ]

            ]
        ];
        return response()->json($response);
    }
}
