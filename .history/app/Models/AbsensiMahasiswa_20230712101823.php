<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AbsensiMahasiswa extends Model
{
    use HasFactory;
    protected $table = 'tbabsensimhs';
    protected $primaryKey = 'id_jadwal';
    public $timestamps = false;
}
