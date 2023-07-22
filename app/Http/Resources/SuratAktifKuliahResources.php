<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SuratAktifKuliahResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'NPM'=>$this->NPM,
            'ID_Surat'=>$this->ID_Surat,
            'Tanggal'=>$this->Tanggal,
            'No_Surat'=>$this->No_Surat,
            'tgl_surat'=>$this->tgl_surat
        ];
    }
}
