<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AktivitasKuliah extends Model
{
    use HasFactory;
    protected $table = 'tbaktivitaskuliah';
    protected $primaryKey = 'npm';
}
