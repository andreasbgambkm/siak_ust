import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeMenu(),
      routes: {
        '/surataktif': (context) => SuratAktif(),
        '/suratsempro': (context) => SuratSempro(),
        '/suratriset': (context) => SuratRiset(),
        '/suratcuti': (context) => SuratCuti(),
        '/tesprogram': (context) => TesProgram(),
        '/seminarisi': (context) => SeminarIsi(),
        '/sidang': (context) => Sidang(),
        '/skpembimbing': (context) => SkPembimbing(),
      },
    );
  }
}

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/surataktif');
              },
              child: Text('Surat Aktif'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/suratsempro');
              },
              child: Text('Surat Sempro'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/suratriset');
              },
              child: Text('Surat Riset'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/suratcuti');
              },
              child: Text('Surat Cuti'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tesprogram');
              },
              child: Text('Tes Program'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/seminarisi');
              },
              child: Text('Seminar ISI'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sidang');
              },
              child: Text('Sidang'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/skpembimbing');
              },
              child: Text('Sk Pembimbing'),
            ),
          ],
        ),
      ),
    );
  }
}

// Buatlah kelas untuk setiap layar, misalnya Screen1, Screen2, dst.
// Contoh:
class SuratAktif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Surat Permohonan Aktif Kuliah',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': 'Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {'label': 'Nama orang tua', 'value': ''},
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Keperluan :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuratSempro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surat Permohonan Seminar Proposal',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': ' Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {
                          'label': 'Judul Tugas Akhir',
                          'value': 'Aplikasi SIAK'
                        },
                      ],
                    ),
                    Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFileUploadButton(
                      title: 'Draft Seminar Proposal',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                    CustomFileUploadButton(
                      title: 'Syarat/Lampiran',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                  ],
                ),
              ),
              CustomTextList(
                texts: [
                  'Softcopy Draft Proposal yang telah disetujui oleh pembimbing untuk diseminarkan',
                  'Softcopy pembayaran Uang Kuliah terakhir',
                  'Softcopy pembayaran Uang Tugas Akhir',
                  'Softcopy Transkrip Sementara',
                  'Softcopy SK Pembimbing',
                  'Softcopy KRS sedang berjalan',
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuratRiset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Surat Permohonan Riset',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': 'Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {'label': 'Judul Tugas Akhir', 'value': ''},
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tempat Penelitian :',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Alamat Penelitian :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuratCuti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Surat Permohonan Cuti',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': 'Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {'label': 'No.HP Mahasiswa', 'value': ''},
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No.HP Orang Tua :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Alamat Orang Tua:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Alasan :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFileUploadButton(
                      title: 'Surat Permohonan dan Syarat Lampiran',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomTextList(
                texts: [
                  'Surat Permohonan Cuti yang ditandatangani Dosen PA, Ka. Prodi dan Dekan',
                  'Softcopy Pembayaran Uang Kuliah Terakhir',
                  'Softcopy Transkrip Sementara',
                  'Softcopy KRS Berjalan',
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TesProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surat Permohonan Tes Program',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': ' Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {
                          'label': 'Judul Tugas Akhir',
                          'value': 'Aplikasi SIAK'
                        },
                      ],
                    ),
                    Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFileUploadButton(
                      title: 'Draft Tugas Akhir',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                    CustomFileUploadButton(
                      title: 'Syarat/Lampiran',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextList(
                texts: [
                  'Softcopy bukti pembayaran uang Test Program',
                  'Softcopy bukti pembayaran uang bimbingan program',
                  'Softcopy Draft Tugas Akhir yang telah disetujui oleh pembimbing',
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeminarIsi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surat Permohonan Seminar Isi',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': ' Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {
                          'label': 'Judul Tugas Akhir',
                          'value': 'Aplikasi SIAK'
                        },
                      ],
                    ),
                    Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFileUploadButton(
                      title: 'Draft Seminar Isi',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                    CustomFileUploadButton(
                      title: 'Syarat/Lampiran',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextList(
                texts: [
                  'Softcopy Draft Tugas Akhir yang telah disetujui oleh Pembimbing untuk diseminarkan',
                  'Softcopy Kartu Bimbingan Tugas Akhir yang diperoleh dari dosen pembimbing',
                  'Softcopy Pembayaran Uang Kuliah Terakhir',
                  'Softcopy Transkip Nilai / Konversi',
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Sidang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surat Permohonan Sidang',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': ' Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                        {
                          'label': 'Judul Tugas Akhir',
                          'value': 'Aplikasi SIAK'
                        },
                      ],
                    ),
                    Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFileUploadButton(
                      title: 'Draft Ujian Meja Hijau',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                    CustomFileUploadButton(
                      title: 'Syarat/Lampiran',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextList(
                texts: [
                  'Softcopy Draft Tugas Akhir yang telah disetujui oleh Pembimbing untuk diseminarkan',
                  'Softcopy Kartu Bimbingan Tugas Akhir yang  diperoleh dari dosen pembimbing',
                  'Softcopy Pembayaran Uang Kuliah Terakhir',
                  'Softcopy Transkip Nilai / Konversi',
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkPembimbing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surat Keterangan Pembimbing',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000)),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': '19081075'},
                        {'label': 'Nama', 'value': ' Aldo'},
                        {'label': 'Program Studi', 'value': 'Sistem Informasi'},
                      ],
                    ),
                    Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF800000)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFileUploadButton(
                      title: 'Syarat/Lampiran',
                      onPressed: () {
                        // Aksi yang ingin dilakukan saat tombol ditekan
                        // Isi dengan kode Anda.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextList(
                texts: [
                  'Softcopy Transkrip Nilai Sementara',
                  'Softcopy pembayaran uang kuliah terakhir semester berjalan',
                  'Softcopy KRS semester berjalan',
                  'Softcopy pengesahan laporan Proyek Perangkat Lunak',
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .red[
                        800]!), // Ganti dengan warna merah maron sesuai kebutuhan
                  ),
                  onPressed: () {
                    // Implementasi aksi saat tombol submit ditekan
                  },
                  child: Text('Kirim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  final List<Map<String, String>> data;

  CustomTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _buildTableRows(),
    );
  }

  List<TableRow> _buildTableRows() {
    return data.map((row) {
      return TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                row['label']!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                ': ${row['value']}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}

class CustomFileUploadButton extends StatelessWidget {
  final String title;

  final void Function() onPressed;

  CustomFileUploadButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xFF800000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Color(0xFF800000)),
                ),
                minimumSize: Size(100, 30),
              ),
              child: Text(
                'Pilih File',
                style: TextStyle(color: Color(0xFF800000)),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'belum ada file',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomTextList extends StatelessWidget {
  final List<String> texts;

  CustomTextList({
    required this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Syarat :',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: texts.map((text) {
            return Text(
              '◉ $text',
              style: TextStyle(
                fontSize: 14,
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Semua berkas diatas disatukan dalam satu file PDF/Word max 2Mb',
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
