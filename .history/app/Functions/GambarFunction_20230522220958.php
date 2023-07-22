<?php

namespace App\Functions;

class GambarFunction
{
    public function logo($kode)
    {
        $fakultas = substr($kode, 0, 2);
        $result = [];

        if ($fakultas == '01') {
            $result['logo'] = "images/logo/ekonomi.jpg";
            $result['watermark'] = "images/watermark/ekonomi.jpg";
        } elseif ($fakultas == '02') {
            $result['logo'] = "images/logo/sastra.jpg";
            $result['watermark'] = "images/watermark/sastra.jpg";
        } elseif ($fakultas == '03') {
            $result['logo'] = "images/logo/teknik.jpg";
            $result['watermark'] = "images/watermark/teknik.jpg";
        } elseif ($fakultas == '04') {
            $result['logo'] = "images/logo/pertanian.jpg";
            $result['watermark'] = "images/watermark/ekonomi.jpg";
        } elseif ($fakultas == '05') {
            $result['logo'] = "images/logo/filsafat.jpg";
            $result['watermark'] = "images/watermark/filsafat.jpg";
        } elseif ($fakultas == '06') {
            $result['logo'] = "images/logo/hukum.jpg";
            $result['watermark'] = "images/watermark/hukum.jpg";
        } elseif ($fakultas == '08') {
            $result['logo'] = "images/logo/fikom.jpg";
            $result['watermark'] = "images/watermark/fikom.jpg";
        } elseif ($fakultas == '09') {
            $result['logo'] = "images/logo/fkip.jpg";
            $result['watermark'] = "images/watermark/fkip.jpg";
        } elseif ($kode == '101') {
            $result['logo'] = "images/logo/filsafat2.jpg";
            $result['watermark'] = "images/watermark/filsafat2.jpg";
        } elseif ($kode == '102') {
            $result['logo'] = "images/logo/hukum.jpg";
            $result['watermark'] = "images/watermark/hukum.jpg";
        } else {
            return "Fakultas tidak ditemukan";
        }

        return $result;
    }
}
