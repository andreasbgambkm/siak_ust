<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailKRS extends Model
{
    use HasFactory;
    protected $table = 'tbdetailkrs';
    protected $primaryKey = 'id_krs';
    public $timestamps = false;
    protected $fillable = [

        'n_sk',
        'n_tugas',
        'n_uts',
        'n_uas',
        'n_prak',
        'N_angka',
        'status_angket',
        'kelas',
        'status_angket',
        'status_nilai',
        'status_transkrip',
    ];

}
