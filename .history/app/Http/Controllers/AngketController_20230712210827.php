<?php

namespace App\Http\Controllers;

use Illuminate\Support\Str;
use Illuminate\Http\Request;

class AngketController extends Controller
{
    public function store(Request $request, $kd_matkul)
    {
        $randomString = Str::random(11);
        // Validasi request yang diterima
        $validatedData = $request->validate([
            'jawaban.*' => 'required|numeric|min:1|max:5',
        ]);
        $matakuliah = JadwalKRS::where('kd_matkul', $kd_matkul)->first();
        $tahunAjaran = $matakuliah->thn_ajaran;

        // Gabungkan jawaban menjadi satu string dengan tanda koma sebagai pemisah
        $pernyataan = implode(',', $validatedData['jawaban']);

        // Simpan angket ke dalam database
        $angket = Angket::create([
            'respondent' => $randomString,
            'kd_matkul' => $kd_matkul,
            'pernyataan' => $pernyataan,
            'thn_ajaran' => $tahunAjaran,

        ]);

        // Berikan respon sukses
        return response()->json([
            'message' => 'Angket berhasil disimpan',
            'data' => $angket,
        ], 201);
    }
}
