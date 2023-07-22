<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pengumuman extends Model
{
    use HasFactory;
    protected $table = 'tbpengumuman';
    protected $primaryKey = 'id_pengumuman';
    protected $visible = ['id_pengumuman','isi'];
}
