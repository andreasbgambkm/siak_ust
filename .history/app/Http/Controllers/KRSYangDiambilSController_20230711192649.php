<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\JadwalKRS;
use App\Models\TahunAjaran;
use Illuminate\Support\Facades\DB;
use App\Models\ProfileMahasiswa;
use App\Models\AktivitasKuliah;

use App\Models\BayanganKRS;
use App\Models\KRS;

use Illuminate\Support\Facades\Cache;

class KRSYangDiambilSController extends Controller
{
    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $response = Cache::remember('krs_data_' . $uid, 2700, function () use ($uid) {
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
            $semesterBerjalan = AktivitasKuliah::where('npm', $uid)
                ->where('thn_ajaran', 'LIKE', '%1')
                ->orWhere('thn_ajaran', 'LIKE', '%2')
                ->get();
            $hitungSemester = $semesterBerjalan->count();
            $ipSemestersSebelum = DB::table('tbaktivitaskuliah')
            ->where('npm', $uid)
            ->where('thn_ajaran', 'NOT LIKE', '%3')
            ->orderBy('thn_ajaran', 'desc')
            ->skip(1) // Melewatkan baris pertama (nilai thn_ajaran paling baru)
            ->first();
            $ip = $ipSemestersSebelum->ip;
            if ($ip >= 3) {
                $maksSKS = 24;
            } elseif ($ip >= 2.5) {
                $maksSKS = 22;
            } elseif ($ip >= 2) {
                $maksSKS = 20;
            } else {
                $maksSKS = 18;
            }
            $maksimal_sks = $maksSKS;
            $get_idKRS = KRS::where('thn_ajaran', $idTa)
                ->where('npm', $npm)
                ->first();

            $response = [
                'user' => [
                    'npm' => $npm,
                    'nama' => $nama,
                    'prodi' => $prodi,
                    'semester_berjalan' => $hitungSemester,
                    'ipsemestersebelum' => $ip,
                    'maks_SKS' => $maksimal_sks,
                ],
            ];

            if ($get_idKRS) {
                $id_krs = $get_idKRS->id_krs;
                $check_KRS = BayanganKRS::where('id_krs', $id_krs)->count();
                $get_KRS = BayanganKRS::where('id_krs', $id_krs)->get();

                $idjadwal = $get_KRS->pluck('id_jadwal')->toArray();

                $get_jadwal = JadwalKRS::whereIn('id', $idjadwal)->get();

                if ($check_KRS == 0) {
                    $response['status'] = false;
                    $response['message'] = 'Belum mengisi KRS!';
                } else {
                    $response['krs_diambil'] = [];

                    foreach ($get_jadwal as $jadwal) {
                        $status = BayanganKRS::where('id_jadwal', $idjadwal)->first();
                        $statuskrs = $status->status;
                        $statuskrsText = $statuskrs == 1 ? 'Diterima' : 'Belum Divalidasi';

                        $response['krs_diambil'][] = [
                            'jadwal' => $jadwal,
                            'statuskrs' => $statuskrsText,
                        ];
                    }

                    $response['status'] = true;
                }
            }

            return $response;
        });

        return response()->json($response);
    }
}
