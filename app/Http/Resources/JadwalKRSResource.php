<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class JadwalKRSResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'kd_matkul'=>$this->kd_matkul,
            'nm_matkul'=>$this->nm_matkul,
            'semester'=>$this->semester,
            'dosen'=>$this->dosen,
            'hari'=>$this->hari,
            'kd_jam'=>$this->kd_jam,
            'kelas'=>$this->kelas
        ];
    }
}
