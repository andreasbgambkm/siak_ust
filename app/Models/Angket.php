<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Angket extends Model
{
    protected $table = 'rekap_angket';

    public $timestamps = false;
    protected $fillable = ['respondent', 'kd_matkul', 'pernyataan', 'thn_ajaran'];

}
