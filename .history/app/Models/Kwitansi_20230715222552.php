<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Kwitansi extends Model
{
    use HasFactory;
    protected $table = 'tbkwitansi';
    protected $primaryKey = 'npm';
    protected $visible = ['kdkwitansi','no_va','jenispembayaran','kat_a','kat_b','kat_c','kat_d','diskon','denda','jlh_bayar'];
}
