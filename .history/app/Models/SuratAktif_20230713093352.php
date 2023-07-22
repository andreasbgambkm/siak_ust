<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratAktif extends Model
{
    use HasFactory;
    protected $table = 'tbsurataktifkuliah';
    public $timestamps = false;
    protected $hidden = ['ID_Surat','NPM','tgl_surat'];
}
