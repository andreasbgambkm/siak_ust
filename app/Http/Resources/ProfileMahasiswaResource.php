<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfileMahasiswaResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'npm'=>$this->npm,
            'nama'=>$this->nm_mhs,
            'tmpt_lahir'=>$this->tmpt_lahir,
            'tgl_lahir'=>$this->tgl_lahir,
            'jk'=>$this->jk,
            'agama'=>$this->agama,
            'provinsi'=>$this->provinsi,
            'kota'=>$this->kota,
            'kabupaten'=>$this->kabupaten,
            'kecamatan'=>$this->kecamatan,
            'kel_mhs'=>$this->kel_mhs,
            'rt_mhs'=>$this->rt_mhs,
            'rw_mhs'=>$this->rw_mhs,
            'nm_ayah'=>$this->nm_ayah,
            'nm_ibu'=>$this->nm_ibu,
            'alamat_ortu'=>$this->alamat_ortu,
            'pekerjaan_ayah'=>$this->pekerjaan_ayah,
            'pekerjaan_ibu'=>$this->pekerjaan_ibu
        ];
    }
}
