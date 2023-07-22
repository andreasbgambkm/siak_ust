<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sidang extends Model
{
    use HasFactory;
    protected $table = 'tbsidang';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $fillable = ['id_surat', 'no_surat', 'no_suratrektor', 'tgl_no_suratrektor', 'tanggalx', 'waktu', 'tanggal', 'tgl_daftar', 'lampiran', 'draft','status'];
}
