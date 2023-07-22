<?php

namespace App\Functions;

class ProfileFunction
{
    public function jenisKelamin($kode)
    {

        if ($kode == 'P') {
            return "PEREMPUAN";
        } elseif ($kode == 'L') {
            return "LAKI-LAKI";
        } else {
            return "";
        }
    }
    public function agama($kode)
    {

        if ($kode == 'P') {
            return "PROTESTAN";
        } elseif ($kode == 'L') {
            return "KATOLIK";
        } elseif ($kode == 'I') {
            return "ISLAM";
        } elseif ($kode == 'H') {
            return "HINDU";
        } elseif ($kode == 'B') {
            return "BUDDHA";
        } else {
            return "";
        }
    }
}
