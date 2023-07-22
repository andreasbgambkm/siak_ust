<?php
public function process($value)
{
    $result = [];

    if ($value = 01) {
        $result['gamabar'] = "images/logo/ekonomi.jpg";
        $result['watermark'] = "images/watermark/ekonomi.jpg";
    } elseif ($value = 02) {
        $result['gamabar'] = "images/logo/sastra.jpg";
        $result['watermark'] = "images/watermark/sastra.jpg";
    } elseif ($value = 03) {
        $result['gamabar'] = "images/logo/teknik.jpg";
        $result['watermark'] = "images/watermark/teknik.jpg";
    }elseif ($value = 04) {
        $result['gamabar'] = "images/logo/pertanian.jpg";
        $result['watermark'] = "images/watermark/ekonomi.jpg";
    }elseif ($value < 10) {
        $result['gamabar'] = "images/logo/filsafat.jpg";
        $result['watermark'] = "images/watermark/filsafat.jpg";
    }elseif ($value < 10) {
        $result['gamabar'] = "images/logo/hukum.jpg";
        $result['watermark'] = "images/watermark/hukum.jpg";
    }elseif ($value < 10) {
        $result['gamabar'] = "images/logo/fikom.jpg";
        $result['watermark'] = "images/watermark/fikom.jpg";
    }elseif ($value < 10) {
        $result['gamabar'] = "images/logo/fkip.jpg";
        $result['watermark'] = "images/watermark/fkip.jpg";
    }elseif ($value < 10) {
        $result['gamabar'] = "images/logo/filsafat2.jpg";
        $result['watermark'] = "images/watermark/filsafat2.jpg";
    }elseif ($value < 10) {
        $result['gamabar'] = "images/logo/filsafat2.jpg";
        $result['watermark'] = "images/watermark/filsafat2.jpg";
    }
    else {
        return "Fakultas tidak ditemukan";
    }

    return $result;
}