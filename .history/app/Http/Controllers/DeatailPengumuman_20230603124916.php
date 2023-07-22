<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DeatailPengumuman extends Controller
{
    public function show()
    {
        $pengumuman = Pengumuman::all();

    }
}
