<?php

namespace App\Functions;

class ProfileFunction
{
    public function jenisKelamin($kode)
    {

        if ($kode == 'P') {
            return "Perempuan";
        } elseif ($kode == 'L') {
            return "Laki-Laki";
        } else {
            return "";
        }
    }
    public function agama($kode)
    {

        if ($kode == 'P') {
            return "Protestan";
        } elseif ($kode == 'L') {
            return "Katolik";
        } elseif ($kode == 'I') {
            return "Islam";
        } elseif ($kode == 'H') {
            return "Hindu";
        } elseif ($kode == 'B') {
            return "Budha";
        } else {
            return "";
        }
    }
}
