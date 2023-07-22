<?php
public function logo($kode)
{
    $result = [];

    if ($kode == 01) {
        $result['gamabar'] = "images/logo/ekonomi.jpg";
        $result['watermark'] = "images/watermark/ekonomi.jpg";
    } elseif ($kode == 02) {
        $result['gamabar'] = "images/logo/sastra.jpg";
        $result['watermark'] = "images/watermark/sastra.jpg";
    } elseif ($kode == 03) {
        $result['gamabar'] = "images/logo/teknik.jpg";
        $result['watermark'] = "images/watermark/teknik.jpg";
    }elseif ($kode == 04) {
        $result['gamabar'] = "images/logo/pertanian.jpg";
        $result['watermark'] = "images/watermark/ekonomi.jpg";
    }elseif ($kode == 05 ) {
        $result['gamabar'] = "images/logo/filsafat.jpg";
        $result['watermark'] = "images/watermark/filsafat.jpg";
    }elseif ($kode == 06) {
        $result['gamabar'] = "images/logo/hukum.jpg";
        $result['watermark'] = "images/watermark/hukum.jpg";
    }elseif ($kode == 07) {
        $result['gamabar'] = "images/logo/fikom.jpg";
        $result['watermark'] = "images/watermark/fikom.jpg";
    }elseif ($kode == 08) {
        $result['gamabar'] = "images/logo/fkip.jpg";
        $result['watermark'] = "images/watermark/fkip.jpg";
    }elseif ($kode == 09) {
        $result['gamabar'] = "images/logo/filsafat2.jpg";
        $result['watermark'] = "images/watermark/filsafat2.jpg";
    }elseif ($kode == 10) {
        $result['gamabar'] = "images/logo/hukum.jpg";
        $result['watermark'] = "images/watermark/hukum.jpg";
    }
    else {
        return "Fakultas tidak ditemukan";
    }

    return $result;
}