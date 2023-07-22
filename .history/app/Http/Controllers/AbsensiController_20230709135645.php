<?php

namespace App\Http\Controllers;

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

        $absensiMahasiswa =DB::table('tbkrs')
        ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
        ->join('tbbayangandetailkrs', 'tbkrs.id_krs', '=', 'tbbayangandetailkrs.id_krs')
        ->join('tbabsensimhs', 'tbbayangandetailkrs.id_jadwal', '=', 'tbabsensimhs.id_jadwal')
        ->join('jadwallengkap', 'tbbayangandetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'tbabsensimhs.status')
        ->where('tbkrs.npm', $uid)
        ->where('tbtahun_ajaran.id_ta', $idTa)
        ->get();

        $jumlahAlpha = 0;
        $jumlahIjin = 0;
        $jumlahSakit = 0;
        $jumlahHadir = 0;

        foreach ($absensiMahasiswa as $absensi) {
            switch ($absensi->status) {
                case 'A':
                    $absensi->status = 'Alpha';
                    $jumlahAlpha++;
                    break;
                case 'I':
                    $absensi->status = 'Ijin';
                    $jumlahIjin++;
                    break;
                case 'S':
                    $absensi->status = 'Sakit';
                    $jumlahSakit++;
                    break;
                case 'H':
                    $absensi->status = 'Hadir';
                    $jumlahHadir++;
                    break;
                default:
                    // Handle default case, if necessary
                    break;
            }
        }
        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2
            ],
            'absensi' => $absensiMahasiswa,
            'jumlahAlpha' => $jumlahAlpha,
            'jumlahIjin' => $jumlahIjin,
            'jumlahSakit' => $jumlahSakit,
            'jumlahHadir' => $jumlahHadir
        ];
        return response()->json($response);
    }
}
