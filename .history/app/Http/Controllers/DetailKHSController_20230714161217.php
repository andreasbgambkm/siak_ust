<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\TahunAjaran;
use App\Models\AktivitasKuliah;
use Illuminate\Support\Facades\DB;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class DetailKHSController extends Controller
{
    public function show($idTA)
    {
        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $npm = $profile->npm;
        $nama = $profile->nm_mhs;
        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);
        $getAktivitaskuliah = AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', $idTA)
        ->first();
        $ip=$getAktivitaskuliah->ip;
        $sks=$getAktivitaskuliah->sks;

        $khs = DB::table('tbkrs')
        ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
        ->join('tbdetailkrs', 'tbkrs.id_krs', '=', 'tbdetailkrs.id_krs')
        ->join('jadwallengkap', 'tbdetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.sks', 'jadwallengkap.kelas', 'jadwallengkap.semester', 'tbdetailkrs.N_angka', )
        ->where('tbkrs.npm', $uid)
        ->where('tbtahun_ajaran.id_ta', $idTA)

        ->get();

        foreach ($khs as $nilai) {
            $nilai->nilai_huruf = '';
            if ($nilai->N_angka <= 45.5) {
                $nilai->nilai_huruf = 'E';
            } elseif ($nilai->N_angka <= 55.5) {
                $nilai->nilai_huruf = 'D';
            } elseif ($nilai->N_angka <= 65.5) {
                $nilai->nilai_huruf = 'C';
            } elseif ($nilai->N_angka <= 70.5) {
                $nilai->nilai_huruf = 'C+';
            } elseif ($nilai->N_angka <= 75.5) {
                $nilai->nilai_huruf = 'B';
            } elseif ($nilai->N_angka <= 80.5) {
                $nilai->nilai_huruf = 'B+';
            } elseif ($nilai->N_angka > 80.5) {
                $nilai->nilai_huruf = 'A';
            }
        }

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,
                'ip' => $ip,
                'totalsks' => $sks,

            ],
            'khs' => $khs
        ];

        return response()->json($response);
    }
}
