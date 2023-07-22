<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use App\Models\ProfileMahasiswa;
use App\Models\AktivitasKuliah;
use Illuminate\Http\Request;
use App\Models\TahunAjaran;
use App\Functions\KodeProdiFunction;

class KHSController extends Controller
{
    public function show(Request $request)
    {
        $uid = auth('sanctum')->user()->id;
        $cacheKey = 'krs:' . $uid; // Menentukan kunci cache unik berdasarkan user ID
        $cacheDuration = 2; // Durasi cache dalam detik

        $response = Cache::remember($cacheKey, $cacheDuration, function () use ($uid) {
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
            $semesterBerjalan =AktivitasKuliah::where('npm', $uid)
            ->where('thn_ajaran', 'LIKE', '%1')
            ->orWhere('thn_ajaran', 'LIKE', '%2')
            ->get();
            $hitungSemester = $semesterBerjalan->count();


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
                    $semester = 'Pendek';
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
                    'fakultas' => $fakultas,
                ],
                'combobox' => $comboboxData,
            ];

            return [
                'user' => [
                    'npm' => $npm,
                    'nama' => $nama,
                    'prodi' => $prodi,
                    'fakultas' => $fakultas,
                ],
                'combobox' => $comboboxData,
            ];
        });

        return response()->json($response);
    }
}
