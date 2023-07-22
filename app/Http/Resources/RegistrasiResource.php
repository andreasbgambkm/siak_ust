<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RegistrasiResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'tgl_registrasi'=>$this->tgl_registrasi,
            'thn_ajaran'=>$this->thn_ajaran,
            'status'=>$this->status,
        ];
    }
}
