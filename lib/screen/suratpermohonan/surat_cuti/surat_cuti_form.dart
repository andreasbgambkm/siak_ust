import 'package:flutter/material.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_file_upload_button.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/custom_text_list.dart';
import 'package:siak/widgets/title.dart';

class SuratCuti extends StatefulWidget {
  @override
  State<SuratCuti> createState() => _SuratCutiState();
}

class _SuratCutiState extends State<SuratCuti> {

  ProfileMahasiswa? _profileMahasiswa;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile =
    await _databaseHelper.getProfileDataFromPreferences();

    setState(() {
      _profileMahasiswa = profile;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {

            Navigator.of(context).pushReplacementNamed("/SPPage");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitlePage(title: 'Surat Permohonan Cuti'),

              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                  BorderRadius.circular(10), // Atur radius sesuai keinginan
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {'label': 'NPM', 'value': "${_profileMahasiswa?.npm ?? ''}"},
                        {'label': 'Nama', 'value':  "${_profileMahasiswa?.nama ?? ''}"},
                        {'label': 'Program Studi', 'value' : "${_profileMahasiswa?.prodi ?? ''}"},
                        {'label': 'No.HP Mahasiswa', 'value': ''},
                      ],
                    ),
                    TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Tambahkan border radius di sini
                          borderSide: const BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan aktif/fokus
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan non-aktif/tidak dalam fokus
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'No.HP Orang Tua :',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Tambahkan border radius di sini
                          borderSide: const BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan aktif/fokus
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan non-aktif/tidak dalam fokus
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Alamat Orang Tua:',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Tambahkan border radius di sini
                          borderSide: BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan aktif/fokus
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan non-aktif/tidak dalam fokus
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Alasan :',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Tambahkan border radius di sini
                          borderSide: BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan aktif/fokus
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary), // Atur warna border berwarna merah ketika TextField dalam keadaan non-aktif/tidak dalam fokus
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SiakColors.SiakPrimary),
                    ),
                    const SizedBox(
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
              const SizedBox(height: 10),
              CustomTextList(
                texts: [
                  'Surat Permohonan Cuti yang ditandatangani Dosen PA, Ka. Prodi dan Dekan',
                  'Softcopy Pembayaran Uang Kuliah Terakhir',
                  'Softcopy Transkrip Sementara',
                  'Softcopy KRS Berjalan',
                ],
              ),
              const SizedBox(height: 20),
              Center(
                 child: ElevatedButton(
                    onPressed: () async {



                    },
                    style: ElevatedButton.styleFrom(
                      primary: SiakColors.SiakPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(double.infinity, 50), // Tambahkan ketinggian (height) di sini
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.send_rounded),
                        SizedBox(width: 8), // Jarak antara ikon dan teks
                        Text('Kirim'),
                      ],
                    ),
                  ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}