<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AbsensiDosen extends Model
{
    use HasFactory;
    protected $table = 'tbabsensidosen';
    protected $primaryKey = 'npm';
}