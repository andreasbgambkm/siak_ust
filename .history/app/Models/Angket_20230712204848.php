<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Angket extends Model
{
    protected $table = 'rekap_angket';
    protected $primaryKey = 'responden';
    public $timestamps = false;
}