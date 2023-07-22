<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratPkl extends Model
{
    use HasFactory;
    protected $table = 'tbsuratpkl';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $hidden = ['id_surat','status','tanggal_daftar','no_surat'];
    protected $fillable = ['id_surat', 'inst', 'jenis', 'alamat', 'no_surat', 'tanggal_surat', 'pimpinan', 'pekerjaan', 'lokasi', 'waktu','status','pembimbing','hpwa','jabatan'];
}
