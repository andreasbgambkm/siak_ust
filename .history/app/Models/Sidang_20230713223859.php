<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sidang extends Model
{
    use HasFactory;
    protected $table = 'tbsidang';
    public $timestamps = false;
    protected $primaryKey = 'npm';
}