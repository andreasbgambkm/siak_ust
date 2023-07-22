<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use App\Models\ProfileMahasiswa;
use App\Models\AktivitasKuliah;
use Illuminate\Http\Request;
use App\Models\TahunAjaran;

class KRSController extends Controller
{
    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $cacheKey = 'krs:' . $uid; // Menentukan kunci cache unik berdasarkan user ID
        $cacheDuration = 2700; // Durasi cache dalam detik

        $response = Cache::remember($cacheKey, $cacheDuration, function () use ($uid) {
            $profile = ProfileMahasiswa::findOrFail($uid);
            $npm = $profile->npm;
            $nama = $profile->nm_mhs;
            $prodi = $profile->kd_prodi;
            $tahunAjaran = TahunAjaran::where('status', 'A')->first();

            $idTa = $tahunAjaran->id_ta;
            $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
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
            $getKRSSebelum =DB::table('tbkrs')
            ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
            ->select('tbkrs.thn_ajaran', 'tbtahun_ajaran.semester', 'tbtahun_ajaran.tahun_ajaran')
            ->where('tbkrs.npm', $uid)
            ->get();

            $comboboxData = [];
            foreach ($getKRSSebelum as $item) {
                $tahunAjaranKRS = $item->tahun_ajaran;
                $ta2 = $tahunAjaranKRS + 1;
                $semesterHuruf = $item->semester;
                if ($semesterHuruf == '1') {
                    $semester = 'Ganjil';
                } elseif ($semesterHuruf == '2') {
                    $semester = 'Genap';
                } else {
                    $semester = 'Semester Pendek';
                }
                $id = $item->thn_ajaran;

                $comboboxData[] = [
                    'id' => $id,
                    'tahun_ajaran' => $tahunAjaranKRS . '/' . $ta2,
                    'semester' => $semester,
                ];
            }


            $response = [
                'user' => [
                    'npm' => $npm,
                    'nama' => $nama,
                    'prodi' => $prodi,
                    'semester_berjalan' => $hitungSemester,
                    'ipsemestersebelum' => $ip,
                    'maks_SKS' => $maksimal_sks,
                ],
                'combobox' => $comboboxData,
            ];

            return [
                'user' => [
                    'npm' => $npm,
                    'nama' => $nama,
                    'prodi' => $prodi,
                    'semester_berjalan' => $hitungSemester,
                    'ipsemestersebelum' => $ip,
                    'maks_SKS' => $maksimal_sks,
                ],
                'combobox' => $comboboxData,
            ];
        });

        return response()->json($response);
    }
}
