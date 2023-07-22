<?php

namespace App\Http\Controllers;

use TCPDF;
use App\Functions\GambarFunction;
use App\Functions\KodeProdiFunction;
use Illuminate\Http\Request;
use App\Models\ProfileMahasiswa;
use App\Models\TahunAjaran;
use Illuminate\Support\Facades\DB;
use App\Models\JadwalKRS;
use App\Models\DetailKRS;
use App\Models\AktivitasKuliah;
use App\Models\Pimpinan;

class DownloadKHSController extends Controller
{
    public function show($id)
    {

        $tahunAjaran = TahunAjaran::where('id_ta', $id)->first();
        $getSemester = $tahunAjaran->semester;
        if ($getSemester == '1') {
            $semester = 'GANJIL';
        } elseif ($getSemester == '2') {
            $semester = 'GENAP';
        } else {
            $semester = 'ANTARA';
        }

        $getTA = $tahunAjaran->tahun_ajaran;
        $getTA2 = $getTA + 1;

        $uid = auth('sanctum')->user()->id;
        $profile = ProfileMahasiswa::findOrFail($uid);
        $nama = $profile->nm_mhs;
        $foto = $profile->Foto;



        $kdfakultas = $profile->fakultas;
        $kdprodi = $profile->kd_prodi;
        $kode = new KodeProdiFunction();
        $prodi = $kode->prodi($kdprodi);
        $fakultas = $kode->fakultas($kdfakultas);

        $gambarFunction = new GambarFunction();
        $result = $gambarFunction->logo($kdfakultas);


        $logo = $result['logo'];


        $jenjang = $profile->jenjang;

        $getAktivitaskuliah = AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', $id)
        ->first();

        $ip = $getAktivitaskuliah->ip;
        if ($ip > 3) {
            $maks_ip = 24;
        } elseif ($ip > 2) {
            $maks_ip = 20;
        } else {
            $maks_ip = 18;
        }
        $maksimal_ip = $maks_ip;
        $totalSks=$getAktivitaskuliah->sks;
        $semesterKHS = TahunAjaran::where('id_ta', $id)->first();

        $semesterAngka = $semesterKHS->semester;
        if ($semesterAngka == '1') {
            $semesterTA = 'Ganjil';
        } elseif ($semesterAngka == '2') {
            $semesterTA = 'Genap';
        } else {
            $semesterTA = 'Pendek';
        }

        $khs = DB::table('tbkrs')
        ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
        ->join('tbdetailkrs', 'tbkrs.id_krs', '=', 'tbdetailkrs.id_krs')
        ->join('jadwallengkap', 'tbdetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.sks', 'jadwallengkap.kelas', 'jadwallengkap.semester', 'tbdetailkrs.N_angka', )
        ->where('tbkrs.npm', $uid)
        ->where('tbtahun_ajaran.id_ta', $id)
        ->get();


        $dataTabel = [];
        foreach ($khs as $item) {
            $kode = $item->kd_matkul;
            $namaMatkul = $item->nm_matkul;
            $kelas = $item->kelas;
            $sks = $item->sks;
            $nilai_huruf = ''; // Menginisialisasi variabel $nilai_huruf
            $semester = $item->semester;
            $N_angka = $item->N_angka;

            if ($N_angka <= 45.5) {
                $nilai_huruf = 'E';
            } elseif ($N_angka <= 55.5) {
                $nilai_huruf = 'D';
            } elseif ($N_angka <= 65.5) {
                $nilai_huruf = 'C';
            } elseif ($N_angka <= 70.5) {
                $nilai_huruf = 'C+';
            } elseif ($N_angka <= 75.5) {
                $nilai_huruf = 'B';
            } elseif ($N_angka <= 80.5) {
                $nilai_huruf = 'B+';
            } elseif ($N_angka > 80.5) {
                $nilai_huruf = 'A';
            }

            $dataTabel[] = [
                'kd_matkul' => $kode,
                'nm_matkul' => $namaMatkul,
                'kelas' => $kelas,
                'sks' => $sks,
                'nilai_huruf' => $nilai_huruf,
                'semester' => $semester,
            ];
        }

        $bulan = array(
            1 => 'Januari',
            2 => 'Februari',
            3 => 'Maret',
            4 => 'April',
            5 => 'Mei',
            6 => 'Juni',
            7 => 'Juli',
            8 => 'Agustus',
            9 => 'September',
            10 => 'Oktober',
            11 => 'November',
            12 => 'Desember'
        );

        $tanggal = date('j') . ' ' . $bulan[date('n')] . ' ' . date('Y');






        $pdf = new TCPDF('P', 'mm', 'A4', true, 'UTF-8', false);

        // Set dokumen informasi
        $pdf->SetCreator($nama);
        $pdf->SetAuthor($uid);
        $pdf->SetTitle('Kartu Hasil Studi');
        $pdf->SetSubject('Kartu Hasil Studi');
        $pdf->SetKeywords('Surat, PDF, KRS, TCPDF');

        // Buat halaman baru
        $pdf->AddPage();


        // Tambahkan kepala surat dengan logo

        $pdf->Image($logo, 12, 12, 28, '', 'JPG', '', 'T', false, 300, 'L', false, false, 0, false, false, false);

        // Set font Times New Roman
        $pdf->SetFont('times', 'B', 12);

        // Tambahkan teks
        $pdf->SetXY(40, 17);
        $pdf->Cell(0, 0, 'UNIVERSITAS KATOLIK SANTO THOMAS', 0, 0, 'C');

        $pdf->SetFont('times', 'B', 10);
        $pdf->SetXY(40, 22);
        $pdf->Cell(0, 0, 'FAKULTAS '.$fakultas, 0, 0, 'C');

        $pdf->SetFont('times', 'B', 9);
        $pdf->SetXY(40, 27);
        $pdf->Cell(0, 0, 'Jl. Setia Budi No. 479-F Tanjung Sari - Medan 20132 Telp : (061)8210161 (4 Lines) : Fax : (061)8213269', 0, 0, 'C');

        $pdf->SetXY(40, 32);
        $pdf->Cell(0, 0, 'Website : www.ust.ac.id Email : info@ust.ac.id', 0, 0, 'C');

        $pdf->SetLineWidth(1);
        $pdf->Line(10, 42, 200, 42);
        $pdf->SetLineWidth(0.5);
        $pdf->Line(10, 43.2, 200, 43.2);

        // Set font Times New Roman
        $pdf->SetFont('times', 'B', 16);

        // Tambahkan teks
        $pdf->SetXY(10, 53);
        $pdf->Cell(0, 0, 'Kartu Hasil Studi (KHS)', 0, 0, 'C');
        $pdf->SetXY(10, 60);
        $pdf->Cell(0, 0, 'Tahun Akademik '.$getTA.'/'.$getTA2.'-' .$semesterTA, 0, 0, 'C');


        $pdf->Image('http://siak.ust.ac.id/simak/stuu/foto/mahasiswa/'.$foto, 46, 46, 21, '', 'JPG', '', 'T', false, 300, 'R', false, false, 0, false, false, false);

        $pdf->SetFont('times', '', 10);
        $pdf->SetXY(15, 80);
        $pdf->Cell(0, 0, 'NPM', 0, 0, 'L');
        $pdf->SetXY(50, 80);
        $pdf->Cell(0, 0, ': '.$uid, 0, 0, 'L');
        $pdf->SetXY(115, 80);
        $pdf->Cell(0, 0, 'Program Studi', 0, 0, 'L');
        $pdf->SetXY(145, 80);
        $pdf->Cell(0, 0, ': '.$prodi, 0, 0, 'L');
        $pdf->SetXY(15, 87);
        $pdf->Cell(0, 0, 'Nama Mahasiswa', 0, 0, 'L');
        $pdf->SetXY(50, 87);
        $pdf->Cell(0, 0, ': '.$nama, 0, 0, 'L');
        $pdf->SetXY(115, 87);
        $pdf->Cell(0, 0, 'Jenjang Program', 0, 0, 'L');
        $pdf->SetXY(145, 87);
        $pdf->Cell(0, 0, ': '.$jenjang, 0, 0, 'L');
        $pdf->SetXY(15, 94);
        $pdf->SetXY(10, 100);
        $html = '<table border="1">
        <tr>
            <th rowspan="1" style="text-align: center; width: 20px;">No</th>
            <th rowspan="1" style="text-align: center;">Kode</th>
            <th rowspan="1" style="text-align: center; width: 230px;">Nama Matakuliah</th>
            <th rowspan="1" style="text-align: center; width: 40px;">Kelas</th>
            <th rowspan="1" style="text-align: center; width: 40px;">Kredit(K) </th>
            <th rowspan="1" style="text-align: center; width: 40px;">Sem</th>
            <th rowspan="1" style="text-align: center; width: 40px;">Nilai Huruf</th>
        </tr>';

        $no = 1;

        // Loop through the data
        foreach ($dataTabel as $row) {
            $html .= '<tr>';
            $html .= '<td style="text-align: center; width: 20px;">' . $no . '</td>';
            $html .= '<td style="text-align: center;">' . $row['kd_matkul'] . '</td>';
            $html .= '<td style="width: 230px;">&nbsp;' . $row['nm_matkul'] . '</td>';
            $html .= '<td style="width: 40px;">&nbsp;' . $row['kelas'] . '</td>';
            $html .= '<td style="width: 40px;">&nbsp;' . $row['sks'] . '</td>';
            $html .= '<td style="width: 40px;"> &nbsp; ' . $row['semester'] . '</td>';
            $html .= '<td style="width: 40px;"> &nbsp; ' . $row['nilai_huruf'] . '</td>';
            $html .= '</tr>';

            // Increment counter
            $no++;
        }


        $html .= '</table><br>
        <div style="width: 50%; text-align: center;"><b>Jumlah (sks):'.$totalSks.'</b></div>
        <div style="width: 50%; text-align: leftt;"><b>IP Semester :'.$ip.'</b></div>
        <div style="width: 50%; text-align: leftt;"><b>Maks. sks Semester Berikutnya:'.$maks_ip.'</b>
        <div style="width: 50%; text-align: right;">Medan, '. $tanggal. '</div>
        <table>
        <tr>
          <th style="text-align: center;"></th>
          <th style="text-align: center;"><b>Ka.Prodi</b></th>
        </tr>
        <tr>
          <td><br><br><br><br></td>
          <td><br><br><br><br></td>
        </tr>
        <tr>
          <td style="text-align: center;"></td>
          <td style="text-align: center;"><b>'. $nama. '</b></td>
        </tr>
      </table>';

        // Tulis HTML ke halaman PDF
        $pdf->writeHTML($html, true, false, true, false, '');

        $file = public_path('KHS('.$id.')_'.$uid.'.pdf');
        $pdf->Output($file, 'F');

        return response()->json([
            'message' => 'Surat PDF berhasil dibuat',
            'file' => url('KHS('.$id.')_'.$uid.'.pdf')
        ]);
        // $response = [
        //     'user' => [
        //     'semester'=>$semester,
        //     'tahun_ajaran'=>$getTA.'/'.$getTA2,
        //     'npm' => $uid,
        //     'nama' => $nama,
        //     'foto' => $foto,
        //     'dosen_pembimbing' => $dosenPembimbing,
        //     'prodi' => $prodi,
        //     'jenjang' => $jenjang,
        //     'ipsemestersebelum' => $ip
        //     ],
        //     'jadwal_krs' => $jadwalKRS
        // ];

        // return response()->json($response);
    }


}
