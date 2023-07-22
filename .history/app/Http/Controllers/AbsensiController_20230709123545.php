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

        $ipSemestersSebelum = DB::table('tbaktivitaskuliah')
        ->where('npm', $uid)
        ->where('thn_ajaran', 'NOT LIKE', '%3')
        ->orderBy('thn_ajaran', 'desc')
        ->skip(1) // Melewatkan baris pertama (nilai thn_ajaran paling baru)
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
        if ($cek_status_krs == 0) {
            $response['message'] = 'Anda belum dapat mengisi KRS. Silahkan membayar UKP terlebih dahulu!';
        } else {
            $response['jadwal_krs'] = $jadwal_krs;
            $response['krs_sesuai'] = $krs_sesuai_semester;
        }
        return response()->json($response);
    }
}
