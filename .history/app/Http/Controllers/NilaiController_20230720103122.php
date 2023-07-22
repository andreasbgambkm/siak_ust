<?php

namespace App\Http\Controllers;

use App\Models\ProfileMahasiswa;
use App\Models\TahunAjaran;
use App\Models\AktivitasKuliah;
use Illuminate\Support\Facades\DB;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;

class NilaiController extends Controller
{
    public function uts()
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
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();

        $idTa = $tahunAjaran->id_ta;
        $getTA = $tahunAjaran->tahun_ajaran;
        $getTA2 = $getTA + 1;
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $hitungSemester = $semesterBerjalan->count();

        $nilaiUts = DB::table('tbkrs')
        ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
        ->join('tbdetailkrs', 'tbkrs.id_krs', '=', 'tbdetailkrs.id_krs')
        ->join('jadwallengkap', 'tbdetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.sks', 'tbdetailkrs.n_uts')
        ->where('tbkrs.npm', $uid)
        ->where('tbtahun_ajaran.id_ta', $idTa)
        ->get();

        $response = [
            'user' => [
                'npm' => $npm,
                'nama' => $nama,
                'prodi' => $prodi,
                'fakultas' => $fakultas,
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2
            ],
            'nilai' => $nilaiUts
        ];

        return response()->json($response);
    }

    public function uas()
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
        $tahunAjaran = TahunAjaran::where('status', 'A')->first();

        $idTa = $tahunAjaran->id_ta;
        $getTA = $tahunAjaran->tahun_ajaran;
        $getTA2 = $getTA + 1;
        $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', 'LIKE', '%1')
        ->orWhere('thn_ajaran', 'LIKE', '%2')
        ->get();
        $hitungSemester = $semesterBerjalan->count();

        $nilaiUAS = DB::table('tbkrs')
        ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
        ->join('tbdetailkrs', 'tbkrs.id_krs', '=', 'tbdetailkrs.id_krs')
        ->join('jadwallengkap', 'tbdetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.sks', 'tbdetailkrs.n_uts', 'tbdetailkrs.n_sk', 'tbdetailkrs.n_tugas', 'tbdetailkrs.n_uts', 'tbdetailkrs.n_uas', 'tbdetailkrs.N_angka', 'tbdetailkrs.status_angket')
        ->where('tbkrs.npm', $uid)
        ->where('tbtahun_ajaran.id_ta', $idTa)
        ->where('tbdetailkrs.status_nilai', "1")
        ->get();

        foreach ($nilaiUAS as $nilai) {
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
                'semester' => $hitungSemester,
                'tahun_ajaran' => $getTA.'/'.$getTA2
            ],
            'nilai' => $nilaiUAS
        ];

        return response()->json($response);
    }
}
