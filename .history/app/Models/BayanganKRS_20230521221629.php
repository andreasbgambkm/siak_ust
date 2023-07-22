<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BayanganKRS extends Model
{
    use HasFactory;
    protected $table = 'tbbayangandetailkrs';
    protected $primaryKey = 'id_krs';
    public $timestamps = false;
}
