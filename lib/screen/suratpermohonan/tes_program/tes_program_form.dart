import 'package:flutter/material.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_file_upload_button.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/custom_text_list.dart';
import 'package:siak/widgets/title.dart';

class TesProgram extends StatefulWidget {
  @override
  State<TesProgram> createState() => _TesProgramState();
}

class _TesProgramState extends State<TesProgram> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  TitlePage(title: 'Surat Permohonan \n Tes Program'),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTable(
                      data: [
                        {
                          'label': 'NPM',
                          'value': "${_profileMahasiswa?.npm ?? ''}"
                        },
                        {
                          'label': 'Nama',
                          'value': "${_profileMahasiswa?.nama ?? ''}"
                        },
                        {
                          'label': 'Program Studi',
                          'value': "${_profileMahasiswa?.prodi ?? ''}"
                        },
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Judul Tugas Akhir',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: SiakColors.SiakBlack,
                        backgroundColor: SiakColors.SiakPrimaryLightColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Upload File',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF800000),
                      ),
                    ),
                    SizedBox(height: 10),
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
              SizedBox(height: 20),
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
                  onPressed: () async {
                    // Aksi yang ingin dilakukan saat tombol ditekan
                    // Isi dengan kode Anda.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: SiakColors.SiakPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.send_rounded),
                      SizedBox(width: 8),
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
