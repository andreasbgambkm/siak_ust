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
    protected $hidden = ['id_surat','NPM','tgl_surat','No_Surat'];
}
