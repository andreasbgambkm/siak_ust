<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratRiset extends Model
{
    use HasFactory;
    protected $table = 'tbsuratriset';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $fillable = ['id_surat', 'tempat_penelitian', 'alamat_peneliatian', 'tanggal', 'no_surat', 'judul', 'ditujukan'];
}
