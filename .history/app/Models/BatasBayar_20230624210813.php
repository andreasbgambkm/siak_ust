<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BatasBayar extends Model
{
    use HasFactory;
    protected $table = 'tbbatasbayar';
    protected $primaryKey = 'id_batasbayar';
}
