<?php

namespace App\Http\Controllers;

use App\Models\JadwalKRS;
use App\Models\DetailKRS;
use App\Models\Angket;
use Illuminate\Http\Request;

class AngketController extends Controller
{
    public function store(Request $request, $kd_matkul)
    {

        // Validasi request yang diterima
        $validatedData = $request->validate([
            'jawaban.*' => 'required|numeric|min:1|max:5',
        ]);
        $matakuliah = JadwalKRS::where('kd_matkul', $kd_matkul)->first();
        $id_jadwal= $matakuliah->id;
        $tahunAjaran = $matakuliah->thn_ajaran;
        $detailkrs = DetailKRS::where('id_jadwal', $id_jadwal)->first();
        $respondent = $detailkrs->id_krs;

        // Gabungkan jawaban menjadi satu string dengan tanda koma sebagai pemisah
        $pernyataan = implode('', $validatedData['jawaban']);

        // Simpan angket ke dalam database
        $angket = Angket::create([
            'respondent' => $respondent,
            'kd_matkul' => $kd_matkul,
            'pernyataan' => $pernyataan,
            'thn_ajaran' => $tahunAjaran,

        ]);
        $detailkrs->status_angket ="1";
        $detailkrs->save();
        // Berikan respon sukses
        return response()->json([
            'message' => 'Angket berhasil disimpan',
            'data' => $angket,
        ], 201);
    }
}
