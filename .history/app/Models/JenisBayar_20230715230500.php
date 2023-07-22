<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JenisBayar extends Model
{
    use HasFactory;
    protected $table = 'tbjenisbayar';
    protected $primaryKey = 'no_jenis_bayar';
}
