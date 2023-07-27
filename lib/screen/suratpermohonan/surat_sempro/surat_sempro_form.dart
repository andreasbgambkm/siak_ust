import 'package:flutter/material.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_file_upload_button.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/custom_text_list.dart';
import 'package:siak/widgets/title.dart';

class SuratSempro extends StatefulWidget {
  @override
  State<SuratSempro> createState() => _SuratSemproState();
}

class _SuratSemproState extends State<SuratSempro> {

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
          icon: Icon(Icons.arrow_back),
          onPressed: () {

            Navigator.of(context).pushReplacementNamed("/SPPage");
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TitlePage(title: 'Surat Permohonan \n Seminar Proposal'),
                ],
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
                        {'label': 'NPM', 'value': "${_profileMahasiswa?.npm ?? ''}"},
                        {'label': 'Nama', 'value':  "${_profileMahasiswa?.nama ?? ''}"},
                        {'label': 'Program Studi', 'value' : "${_profileMahasiswa?.prodi ?? ''}"},

                      ],
                    ),
                    const Text(
                      'Judul Tugas Akhir',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SiakColors.SiakBlack, backgroundColor: SiakColors.SiakPrimaryLightColor),
                    ),
                   const  SizedBox(height: 10,),
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
                    const  SizedBox(height: 10,),
                    const Text(
                      'Upload File',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SiakColors.SiakBlack),
                    ),
                    const SizedBox(
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

                      },
                    ),
                  ],
                ),
              ),
              CustomTextList(
                texts: const [
                  'Softcopy Draft Proposal yang telah disetujui oleh pembimbing untuk diseminarkan',
                  'Softcopy pembayaran Uang Kuliah terakhir',
                  'Softcopy pembayaran Uang Tugas Akhir',
                  'Softcopy Transkrip Sementara',
                  'Softcopy SK Pembimbing',
                  'Softcopy KRS sedang berjalan',
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
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
              const  SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}