<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratAktif extends Model
{
    use HasFactory;
    protected $table = 'tbsurataktifkuliah';
    public $timestamps = false;
    protected $hidden = ['ID_Surat','tgl_surat','No_Surat'];
    protected $primaryKey = 'NPM';
    protected $fillable = ['ID_Surat', 'Tanggal', 'No_Surat', 'tgl_surat', 'keperluan', 'ta', 'nmortu'];
}
