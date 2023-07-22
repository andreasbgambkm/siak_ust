<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SKPembimbing extends Model
{
    use HasFactory;
    protected $table = 'tbskpembimbing';
    public $timestamps = false;
    protected $primaryKey = 'npm';
    protected $fillable = ['id_surat', 'tgl_daftar', 'lampiran', 'status'];
}
