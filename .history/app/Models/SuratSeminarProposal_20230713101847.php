<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratSeminarProposal extends Model
{
    use HasFactory;
    protected $table = 'tbsuratsempro';
    public $timestamps = false;
    protected $hidden = ['ID_Surat','NPM','tgl_surat','No_Surat'];
}
