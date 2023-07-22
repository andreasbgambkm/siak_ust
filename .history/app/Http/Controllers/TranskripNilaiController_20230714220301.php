<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use App\Models\ProfileMahasiswa;
use Illuminate\Http\Request;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;
use App\Models\AktivitasKuliah;

class TranskripNilaiController extends Controller
{
    public function show()
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
        ->orderBy('total_sks', 'desc') // Menyortir berdasarkan total_sks secara menurun
        ->first();
        $ipk=$getAktivitaskuliah->ipk;
        $totalSks=$getAktivitaskuliah->total_sks;

        $transkripnilai = DB::table('tbkrs')
        ->join('tbdetailkrs', 'tbkrs.id_krs', '=', 'tbdetailkrs.id_krs')
        ->join('jadwallengkap', 'tbdetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.sks', 'jadwallengkap.kelas', 'jadwallengkap.semester', 'tbdetailkrs.N_angka', )
        ->where('tbkrs.npm', $uid)
        ->get();

        foreach ($transkripnilai as $nilai) {
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
                'ipk' => $ipk,
                'totalsks' => $totalSks,

            ],
            'trankrip_nilai' => $transkripnilai
        ];

        return response()->json($response);
    }
}
