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
use App\Models\Dosen;
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

        $ipSemestersSebelum = DB::table('tbaktivitaskuliah')
        ->where('npm', $uid)
        ->where('thn_ajaran', 'NOT LIKE', '%3')
        ->orderBy('thn_ajaran', 'desc')
        ->skip(1) // Melewatkan baris pertama (nilai thn_ajaran paling baru)
        ->first();

        $ip = $ipSemestersSebelum->ip;
        if ($ip > 3) {
            $maks_ip = 24;
        } elseif ($ip > 2) {
            $maks_ip = 20;
        } else {
            $maks_ip = 18;
        }
        $maksimal_ip = $maks_ip;

        $getAktivitaskuliah = AktivitasKuliah::where('npm', $uid)
        ->where('thn_ajaran', $id)
        ->first();
        $ip=$getAktivitaskuliah->ip;
        $totalSks=$getAktivitaskuliah->sks;

        $khs = DB::table('tbkrs')
        ->join('tbtahun_ajaran', 'tbkrs.thn_ajaran', '=', 'tbtahun_ajaran.id_ta')
        ->join('tbdetailkrs', 'tbkrs.id_krs', '=', 'tbdetailkrs.id_krs')
        ->join('jadwallengkap', 'tbdetailkrs.id_jadwal', '=', 'jadwallengkap.id')
        ->select('jadwallengkap.kd_matkul', 'jadwallengkap.nm_matkul', 'jadwallengkap.sks', 'jadwallengkap.kelas', 'jadwallengkap.semester', 'tbdetailkrs.N_angka', )
        ->where('tbkrs.npm', $uid)
        ->where('tbtahun_ajaran.id_ta', $idTA)

        ->get();

        $dataTabel = [];
        foreach ($jadwalKRS as $item) {
            $kode = $item->kd_matkul;
            $namaMatkul = $item->nm_matkul;
            $kategori = $item->kategori;
            $sks = $item->sks;
            $kelas = $item->kelas;
            $hari = $item->hari;
            $jam = $item->kd_jam;
            $namaDosen = $item->dosen;
            if ($kategori == 'T') {
                $T = $sks;
                $P = 0;
            } else {
                $P = $sks;
                $T = 0;
            }


            $dataTabel[] = [
                'kd_matkul' => $kode,
                'nm_matkul' => $namaMatkul,
                'T' => $T,
                'P' => $P,
                'kelas' => $kelas,
                'hari' => $hari,
                'kd_jam' => $jam,
                'nmdos' => $namaDosen,
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
        $pdf->Cell(0, 0, 'KARTU RENCANA STUDI', 0, 0, 'C');
        $pdf->SetXY(10, 60);
        $pdf->Cell(0, 0, 'SEMESTER : '.$semester.' TA.'.$getTA.'/'.$getTA2, 0, 0, 'C');


        $pdf->Image('http://siak.ust.ac.id/simak/stuu/foto/mahasiswa/'.$foto, 46, 46, 21, '', 'JPG', '', 'T', false, 300, 'R', false, false, 0, false, false, false);

        $pdf->SetFont('times', '', 10);
        $pdf->SetXY(15, 80);
        $pdf->Cell(0, 0, 'Nama Mahasiswa', 0, 0, 'L');
        $pdf->SetXY(50, 80);
        $pdf->Cell(0, 0, ': '.$nama, 0, 0, 'L');
        $pdf->SetXY(115, 80);
        $pdf->Cell(0, 0, 'Program Studi', 0, 0, 'L');
        $pdf->SetXY(145, 80);
        $pdf->Cell(0, 0, ': '.$prodi, 0, 0, 'L');
        $pdf->SetXY(15, 87);
        $pdf->Cell(0, 0, 'NPM', 0, 0, 'L');
        $pdf->SetXY(50, 87);
        $pdf->Cell(0, 0, ': '.$uid, 0, 0, 'L');
        $pdf->SetXY(115, 87);
        $pdf->Cell(0, 0, 'Jenjang Program', 0, 0, 'L');
        $pdf->SetXY(145, 87);
        $pdf->Cell(0, 0, ': '.$jenjang, 0, 0, 'L');
        $pdf->SetXY(15, 94);
        $pdf->Cell(0, 0, 'Dosen PA', 0, 0, 'L');
        $pdf->SetXY(50, 94);
        $pdf->Cell(0, 0, ': '.$dosenPembimbing, 0, 0, 'L');
        $pdf->SetXY(65, 101);
        $pdf->Cell(0, 0, 'IP Semester yang Lalu', 0, 0, 'L');
        $pdf->SetXY(110, 101);
        $pdf->Cell(0, 0, ': '.$ip, 0, 0, 'L');
        $pdf->SetXY(65, 108);
        $pdf->Cell(0, 0, 'Maksimum SKS Semester ini', 0, 0, 'L');
        $pdf->SetXY(110, 108);
        $pdf->Cell(0, 0, ': '.$maksimal_ip, 0, 0, 'L');




        $pdf->SetXY(10, 120);
        $html = '<table border="1">
        <tr>
            <th rowspan="2" style="text-align: center; width: 20px;">No</th>
            <th rowspan="2" style="text-align: center;">Kode</th>
            <th rowspan="2" style="text-align: center; width: 160px;">Nama Matakuliah</th>
            <th colspan="2" style="text-align: center; width: 40px;">SKS</th>
            <th colspan="3" style="text-align: center; width: 100px;">Jadwal</th>
            <th rowspan="2" style="text-align: center; width: 160px;">Nama Dosen</th>
        </tr>
        <tr>
            <th style="text-align: center; width: 20px;">T</th>
            <th style="text-align: center; width: 20px;">P</th>
            <th style="text-align: center; width: 25px;">Kelas</th>
            <th style="text-align: center; width: 45px;">Hari</th>
            <th style="text-align: center;width: 30px;">Jam</th>
        </tr>';

        $no = 1;

        // Loop through the data
        foreach ($dataTabel as $row) {
            $html .= '<tr>';
            $html .= '<td style="text-align: center; width: 20px;">' . $no . '</td>';
            $html .= '<td style="text-align: center;">' . $row['kd_matkul'] . '</td>';
            $html .= '<td style="width: 160px;">&nbsp;' . $row['nm_matkul'] . '</td>';
            $html .= '<td style="text-align: center; width: 20px;">' . $row['T'] . '</td>';
            $html .= '<td style="text-align: center; width: 20px;">' . $row['P'] . '</td>';
            $html .= '<td style="text-align: center; width: 25px;">' . $row['kelas'] . '</td>';
            $html .= '<td style="text-align: center; width: 45px;">' . $row['hari'] . '</td>';
            $html .= '<td style="text-align: center; width: 30px;">' . $row['kd_jam'] . '</td>';
            $html .= '<td style="width: 160px;"> &nbsp; ' . $row['nmdos'] . '</td>';
            $html .= '</tr>';

            // Increment counter
            $no++;
        }

        $html .= '</table><br><br><br>
        <div style="width: 50%; text-align: right;">Medan, '. $tanggal. '</div><br><br>
        <table>
        <tr>
          <th style="text-align: center;">Dosen Wali/PA</th>
          <th style="text-align: center;">Mahasiswa</th>
        </tr>
        <tr>
          <td><br><br><br><br><br><br></td>
          <td><br><br><br><br><br><br></td>
        </tr>
        <tr>
          <td style="text-align: center;">'. $dosenPembimbing. '</td>
          <td style="text-align: center;">'. $nama. '</td>
        </tr>
      </table>';

        // Tulis HTML ke halaman PDF
        $pdf->writeHTML($html, true, false, true, false, '');

        $file = public_path('KRS('.$id.')_'.$uid.'.pdf');
        $pdf->Output($file, 'F');

        return response()->json([
            'message' => 'Surat PDF berhasil dibuat',
            'file' => url('KRS('.$id.')_'.$uid.'.pdf')
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
