<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TesProgram extends Model
{
    use HasFactory;
    protected $table = 'tbsuratriset';
    public $timestamps = false;
    protected $primaryKey = 'id';
}
