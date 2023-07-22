<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratSeminarProposal extends Model
{
    use HasFactory;
    protected $table = 'tbsuratsempro';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $fillable = ['id_surat', 'tanggal', 'tanggalx', 'no_surat', 'judul', 'waktu', 'hari','draft','tgl_daftar','status','lampiran'];
}
