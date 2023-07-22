<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TesProgram extends Model
{
    use HasFactory;
    protected $table = 'tbtesprogram';
    public $timestamps = false;
    protected $primaryKey = 'id';
    protected $fillable = ['no_surat', 'id_surat', 'tanggalsurat', 'tgl_daftar', 'draft', 'lampiran', 'status'];
}
