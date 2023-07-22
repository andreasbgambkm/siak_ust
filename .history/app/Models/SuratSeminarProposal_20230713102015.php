<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratSeminarProposal extends Model
{
    use HasFactory;
    protected $table = 'tbsuratsempro';
    public $timestamps = false;
    protected $hidden = [
      "id_surat",
        "npm",
        "tanggal",
        "tanggalx",
        "no_surat",
        "judul",
        "waktu",
        "hari",
        "draft",
        "lampiran",
        "status",
        "tgl_daftar"];
}
