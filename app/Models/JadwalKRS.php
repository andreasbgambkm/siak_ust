<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\TahunAjaran;

class JadwalKRS extends Model
{
    use HasFactory;
    protected $table = 'jadwallengkap';
    protected $primaryKey = 'id';
    protected $visible = ['id','kd_matkul','nm_matkul','semester','sks','dosen','hari','kd_jam','kelas'];




}
