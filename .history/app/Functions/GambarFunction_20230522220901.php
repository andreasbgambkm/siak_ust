<?php

namespace App\Functions;

class GambarFunction
{
    public function logo($kode)
    {
        $fakultas = substr($kode, 0, 2);
        $result = [];

        if ($kode == '01') {
            $result['logo'] = "images/logo/ekonomi.jpg";
            $result['watermark'] = "images/watermark/ekonomi.jpg";
        } elseif ($kode == '02') {
            $result['logo'] = "images/logo/sastra.jpg";
            $result['watermark'] = "images/watermark/sastra.jpg";
        } elseif ($kode == '03') {
            $result['logo'] = "images/logo/teknik.jpg";
            $result['watermark'] = "images/watermark/teknik.jpg";
        } elseif ($kode == '04') {
            $result['logo'] = "images/logo/pertanian.jpg";
            $result['watermark'] = "images/watermark/ekonomi.jpg";
        } elseif ($kode == '05') {
            $result['logo'] = "images/logo/filsafat.jpg";
            $result['watermark'] = "images/watermark/filsafat.jpg";
        } elseif ($kode == '06') {
            $result['logo'] = "images/logo/hukum.jpg";
            $result['watermark'] = "images/watermark/hukum.jpg";
        } elseif ($kode == '08') {
            $result['logo'] = "images/logo/fikom.jpg";
            $result['watermark'] = "images/watermark/fikom.jpg";
        } elseif ($kode == '09') {
            $result['logo'] = "images/logo/fkip.jpg";
            $result['watermark'] = "images/watermark/fkip.jpg";
        } elseif ($kode == '10') {
            $result['logo'] = "images/logo/filsafat2.jpg";
            $result['watermark'] = "images/watermark/filsafat2.jpg";
        } else {
            return "Fakultas tidak ditemukan";
        }

        return $result;
    }
}
