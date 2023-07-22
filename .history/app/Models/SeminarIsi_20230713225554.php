<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SeminarIsi extends Model
{
    use HasFactory;
    protected $table = 'tbseminarisi';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $fillable = ['id_surat', 'tanggal2', 'waktu', 'mhs_pem1', 'mhs_pem2', 'hari', 'tanggal', 'draft', 'lampiran', 'tgl_daftar','status'];
}
