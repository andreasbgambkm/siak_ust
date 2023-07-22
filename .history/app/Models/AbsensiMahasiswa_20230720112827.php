<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AbsensiMahasiswa extends Model
{
    use HasFactory;
    protected $table = 'tbabsensimhs';
    public $timestamps = false;
    protected $primaryKey = 'npm';
}
