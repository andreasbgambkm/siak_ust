<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RincianAbsenController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'status' => 'required|in:H,A,I,S',
        ]);

        $status = $absenMahasiswa->status . $request->status;
        $absenMahasiswa->update(['status' => $status]);
        return response()->json(['message' => 'Status updated successfully'], 200);

    }
}
