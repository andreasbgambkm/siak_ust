<?php

namespace App\Functions;

class WatermarkFunction
{
    public function process($value)
    {
        if ($value > 10) {
            return "Nilai lebih besar dari 10";
        } elseif ($value < 10) {
            return "Nilai lebih kecil dari 10";
        } else {
            return "Nilai sama dengan 10";
        }
    }
}
