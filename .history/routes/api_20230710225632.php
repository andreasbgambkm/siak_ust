<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileMahasiswaController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthenticationController;
use App\Http\Controllers\SuratAktifKuliahController;
use App\Http\Controllers\ChangePasswordContrroller;
use App\Http\Controllers\RegistrasiController;
use App\Http\Controllers\IsiKRSController;
use App\Http\Controllers\KRSController;
use App\Http\Controllers\DownloadKRSController;
use App\Http\Controllers\KRSYangDiambilSController;
use App\Http\Controllers\DetailPengumuman;
use App\Http\Controllers\KwitansiController;
use App\Http\Controllers\AbsensiController;
use App\Http\Controllers\RincianAbsenController;

Route::post('/login', [AuthenticationController::class,'login']);


Route::group(['middleware' => ['auth:sanctum'],['token.name:API-Application']], function () {
    Route::get('/surataktifkuliah', [SuratAktifKuliahController::class,'show']);
    Route::post('/surataktifkuliah', [SuratAktifKuliahController::class,'store']);
    Route::get('/logout', [AuthenticationController::class,'logout']);
    Route::get('/profile', [ProfileMahasiswaController::class,'show']);
    Route::get('/isikrs', [IsiKRSController::class,'show']);
    Route::get('/home', [HomeController::class,'show']);
    Route::get('/registrasi', [RegistrasiController::class,'show']);
    Route::get('/krs', [KRSController::class,'show']);
    Route::get('/krs/{id}', [DownloadKRSController::class,'show']);
    Route::get('/krsdiambil/', [KRSYangDiambilSController::class,'show']);
    Route::post('/changepassword', [ChangePasswordContrroller::class, 'changePassword']);
    Route::post('/isikrs', [IsiKRSController::class,'store']);
    Route::get('/pengumuman', [DetailPengumuman::class,'show']);
    Route::get('/uangkuliah', [KwitansiController::class,'show']);
    Route::get('/dibayar', [KwitansiController::class,'dibayar']);
    Route::get('/absensi', [AbsensiController::class,'show']);
    Route::get('/rincianabsen/{id_jadwal}', [RincianAbsenController::class,'show']);
});
