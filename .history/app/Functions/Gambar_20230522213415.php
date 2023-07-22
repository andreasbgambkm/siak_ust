<?php

namespace App\Functions;

class GambarFunction
{
    public function logo($kode)
    {
        $result = [];
    
        if ($kode == 01) {
            $result['gambar'] = "images/logo/ekonomi.jpg";
            $result['watermark'] = "images/watermark/ekonomi.jpg";
        } elseif ($kode == 02) {
            $result['gambar'] = "images/logo/sastra.jpg";
            $result['watermark'] = "images/watermark/sastra.jpg";
        } elseif ($kode == 03) {
            $result['gambar'] = "images/logo/teknik.jpg";
            $result['watermark'] = "images/watermark/teknik.jpg";
        }elseif ($kode == 04) {
            $result['gambar'] = "images/logo/pertanian.jpg";
            $result['watermark'] = "images/watermark/ekonomi.jpg";
        }elseif ($kode == 05 ) {
            $result['gambar'] = "images/logo/filsafat.jpg";
            $result['watermark'] = "images/watermark/filsafat.jpg";
        }elseif ($kode == 06) {
            $result['gambar'] = "images/logo/hukum.jpg";
            $result['watermark'] = "images/watermark/hukum.jpg";
        }elseif ($kode == 07) {
            $result['gambar'] = "images/logo/fikom.jpg";
            $result['watermark'] = "images/watermark/fikom.jpg";
        }elseif ($kode == 08) {
            $result['gambar'] = "images/logo/fkip.jpg";
            $result['watermark'] = "images/watermark/fkip.jpg";
        }elseif ($kode == 09) {
            $result['gambar'] = "images/logo/filsafat2.jpg";
            $result['watermark'] = "images/watermark/filsafat2.jpg";
        }elseif ($kode == 10) {
            $result['gambar'] = "images/logo/hukum.jpg";
            $result['watermark'] = "images/watermark/hukum.jpg";
        }
        else {
            return "Fakultas tidak ditemukan";
        }
    
        return $result;
    }
}
