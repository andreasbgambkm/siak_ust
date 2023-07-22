<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileMahasiswaController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\AuthenticationController;
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
use App\Http\Controllers\NilaiController;
use App\Http\Controllers\AngketController;
use App\Http\Controllers\SuratController;
use App\Http\Controllers\SuratAktifKuliahController;
use App\Http\Controllers\SuratSemproController;
use App\Http\Controllers\SuratRisetController;
use App\Http\Controllers\SuratCutiController;
use App\Http\Controllers\TesProgramController;
use App\Http\Controllers\SeminarIsiController;

Route::post('/login', [AuthenticationController::class,'login']);


Route::group(['middleware' => ['auth:sanctum'],['token.name:API-Application']], function () {

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
    Route::post('/absenmahasiswa/{id_jadwal}', [RincianAbsenController::class,'store']);
    Route::get('/uts', [NilaiController::class,'uts']);
    Route::get('/uas', [NilaiController::class,'uas']);
    Route::post('/isiangket/{kd_matkul}', [AngketController::class,'store']);
    Route::get('/surat', [SuratController::class,'show']);
    Route::get('/surataktif', [SuratAktifKuliahController::class,'show']);
    Route::post('/isisurataktif', [SuratAktifKuliahController::class,'store']);
    Route::get('/suratsempro', [SuratSemproController::class,'show']);
    Route::post('/isisuratsempro', [SuratSemproController::class,'store']);
    Route::get('/suratriset', [SuratRisetController::class,'show']);
    Route::post('/isisuratriset', [SuratRisetController::class,'store']);
    Route::get('/suratcuti', [SuratCutiController::class,'show']);
    Route::post('/isisuratcuti', [SuratCutiController::class,'store']);
    Route::get('/tesprogram', [TesProgramController::class,'show']);
    Route::post('/isitesprogram', [TesProgramController::class,'store']);
    Route::get('/seminarisi', [SeminarIsiController::class,'show']);
    Route::post('/isiseminarisi', [SeminarIsiController::class,'store']);
    Route::get('/sidang', [SidangController::class,'show']);
    Route::post('/isisidang', [SidangController::class,'store']);

});
