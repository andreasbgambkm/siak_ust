<?php
public function process($value)
{
    $result = [];

    if ($value > 10) {
        $result['gamabar'] = "images/logo/fikom.jpg";
        $result['watermark'] = "Nilai lebih besar dari 10";
    } elseif ($value < 10) {
        $result['status'] = "Lebih kecil dari 10";
        $result['message'] = "Nilai lebih kecil dari 10";
    } else {
        $result['status'] = "Sama dengan 10";
        $result['message'] = "Nilai sama dengan 10";
    }

    return $result;
}