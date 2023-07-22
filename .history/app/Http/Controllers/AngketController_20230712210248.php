<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AngketController extends Controller
{
    public function store(Request $request, $kd_matkul)
    {
        // Validasi request yang diterima
        $validatedData = $request->validate([
            'jawaban.*' => 'required|numeric|min:1|max:5',
        ]);

        // Gabungkan jawaban menjadi satu string dengan tanda koma sebagai pemisah
        $pernyataan = implode(',', $validatedData['jawaban']);

        // Simpan angket ke dalam database
        $angket = Angket::create([
            'respondent' => $validatedData['respondent'],
            'kd_matkul' => $validatedData['kd_matkul'],
            'pernyataan' => $pernyataan,
            'thn_ajaran' => $validatedData['thn_ajaran'],
            'saran' => $validatedData['saran'],
        ]);

        // Berikan respon sukses
        return response()->json([
            'message' => 'Angket berhasil disimpan',
            'data' => $angket,
        ], 201);
    }
}
