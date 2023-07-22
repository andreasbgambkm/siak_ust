<?php

namespace App\Functions;

class KodeProdiFunction
{
    public function fakultas($kode)
    {

        if ($kode == '01') {
            return "EKONOMI";
        } elseif ($kode == '02') {
            return "SASTRA";
        } elseif ($kode == '03') {
            return "TEKNIK";
        } elseif ($kode == '04') {
            return "PERTANIAN";
        } elseif ($kode == '05') {
            return "FILSAFAT";
        } elseif ($kode == '06') {
            return "HUKUM";
        } elseif ($kode == '08') {
            return "ILMU KOMPUTER";
        } elseif ($kode == '09') {
            return "KEGURUAN DAN ILMU PENDIDIKAN ";
        } elseif ($kode == '101') {
            return "MAGISTER ILMU FILSAFAT";
        } elseif ($kode == '102') {
            return "MAGISTER ILMU HUKUM";
        } else {
            return "";
        }
    }
    public function prodi($kode)
    {

        if ($kode == '011') {
            return "Manajemen";
        } elseif ($kode == '012') {
            return "Akuntansi";
        } elseif ($kode == '013') {
            return "Administrasi Perkantoran";
        } elseif ($kode == '014') {
            return "Akuntansi";
        } elseif ($kode == '021') {
            return "Sastra Inggris";
        } elseif ($kode == '031') {
            return "Teknik Sipil";
        } elseif ($kode == '032') {
            return "Arsitektur";
        } elseif ($kode == '041') {
            return "Teknologi Hasil Pertanian ";
        } elseif ($kode == '042') {
            return "Agroteknologi";
        } elseif ($kode == '043') {
            return "Agribisnis";
        } elseif ($kode == '051') {
            return "Ilmu Filsafata";
        } elseif ($kode == '060') {
            return "Ilmu Hukum";
        } elseif ($kode == '081') {
            return "Sistem Informasi";
        } elseif ($kode == '084') {
            return "Teknik Informatika";
        } elseif ($kode == '091') {
            return "Pendidikan Guru Sekolah Dasar";
        } elseif ($kode == '092') {
            return "Pendidikan Bahasa dan Sastra Indonesia";
        } elseif ($kode == '093') {
            return "Pendidikan Bahasa Inggris";
        } elseif ($kode == '094') {
            return "Pendidikan Matematika";
        } elseif ($kode == '101') {
            return "Magister Ilmu Filsafat";
        } elseif ($kode == '102') {
            return "Magister Ilmu Hukum";
        } else {
            return "Prodi Tidak Ditemukan";
        }
    }
}
