<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DeatailPengumuman extends Controller
{
    public function show($id)
    {
        $pengumuman = Pengumuman::where('id_pengumuman', $id)->first();
    }
}
