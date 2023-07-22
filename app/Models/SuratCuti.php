<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratCuti extends Model
{
    use HasFactory;
    protected $table = 'tbsuratcuti';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $fillable = ['id_surat', 'no_surat', 'tgl_surat', 'alasan', 'nohp', 'semester', 'tanggal', 'ta', 'status_pa', 'tgl_pa','status_kaprodi','tgl_kaprodi','status_dekan','tgl_dekan','lampiran','Keterangan','Keteranganpa','keterangandekan','nohportu'];
}
