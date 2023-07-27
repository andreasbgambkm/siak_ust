import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/screen/suratpermohonan/sp.dart';
import 'package:siak/screen/suratpermohonan/surat_aktif/preview_surat_aktif/preview_surat_aktif.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SuratAktif extends StatefulWidget {
  @override
  State<SuratAktif> createState() => _SuratAktifState();
}

class _SuratAktifState extends State<SuratAktif> {
  ProfileMahasiswa? _profileMahasiswa;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  TextEditingController namaOrtuController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  dynamic token;

  bool isSendingData = false;

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile =
    await _databaseHelper.getProfileDataFromPreferences();

    setState(() {
      _profileMahasiswa = profile;
    });
  }

  Future<void> _loadTokenDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenData = prefs.getString('token');
    print("Di bawah ini merupakan token dari local");
    print(tokenData);

    if (tokenData != null && tokenData.isNotEmpty) {
      setState(() {
        token = tokenData;
      });
    }
  }



  Future<void> _showResponseDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadTokenDataFromPreferences();
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _sendData() async {
    setState(() {
      isSendingData = true;
    });

    String namaOrtu = namaOrtuController.text;
    String keperluan = keperluanController.text;

    if (namaOrtu.isEmpty || keperluan.isEmpty) {
      _showErrorDialog('Isi semua kolom isian.');
      setState(() {
        isSendingData = false;
      });
      return;
    } else{

      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(
        max: 100,
        msg: 'Memproses Surat Aktif...',
        progressType: ProgressType.valuable,
      );
      pd.close();

      await _databaseHelper.postSuratAktif(namaOrtu, keperluan, token);



      // Tampilkan toast bahwa unduhan telah selesai
      Fluttertoast.showToast(msg: 'Permohonan Surat Aktif Berhasil Dikirim!', toastLength: Toast.LENGTH_SHORT);
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => PreviewSuratAktif()),
      );

      // Tutup dialog setelah unduhan selesai
      pd.close();




  }

    setState(() {
      isSendingData = false;
    });
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Surat Permohonan Aktif Kuliah',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: SiakColors.SiakPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              SPWelcomingCard(nama: _profileMahasiswa?.nama , height: 120, msg: "Silahkan Isi Form Di Bawah Ini",),
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
                        {
                          'label': 'Nama orang tua',
                          'value': '',
                        },
                      ],
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: namaOrtuController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: SiakColors.SiakPrimary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: SiakColors.SiakPrimary,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: SiakColors.SiakPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Keperluan :',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 4,
                      controller: keperluanController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSendingData ? null : _sendData,
                style: ElevatedButton.styleFrom(
                  primary: SiakColors.SiakPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isSendingData) CircularProgressIndicator(),
                    SizedBox(width: 8),
                    Text('Kirim'),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
