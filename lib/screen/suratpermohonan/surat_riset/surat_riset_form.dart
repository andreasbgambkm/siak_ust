import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/screen/suratpermohonan/surat_riset/preview_surat_riset/preview_surat_riset.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/title.dart';

class SuratRiset extends StatefulWidget {
  @override
  State<SuratRiset> createState() => _SuratRisetState();
}

class _SuratRisetState extends State<SuratRiset> {



  TextEditingController judulTAController = TextEditingController();
  TextEditingController tempatPenelitianController = TextEditingController();
  TextEditingController alamatPenelitianController = TextEditingController();
  bool isSendingData = false;
  ProfileMahasiswa? _profileMahasiswa;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  dynamic token;



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

    String judulTA = judulTAController.text;
    String tempatPenelitian = tempatPenelitianController.text;
    String alamatPenelitian = alamatPenelitianController.text;

    if (judulTA.isEmpty || tempatPenelitian.isEmpty || alamatPenelitian.isEmpty) {
      _showErrorDialog('Isi semua kolom isian.');
      setState(() {
        isSendingData = false;
      });
      return;
    } else{



      await _databaseHelper.postSuratRiset(judulTA, tempatPenelitian, alamatPenelitian, token);



      // Tampilkan toast bahwa unduhan telah selesai
      Fluttertoast.showToast(msg: 'Permohonan Surat Aktif Berhasil Dikirim!', toastLength: Toast.LENGTH_SHORT);
      _showPreviewPage();






    }

    setState(() {
      isSendingData = false;
    });
  }

  void _showPreviewPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewSuratRiset(

        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadTokenDataFromPreferences();
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
             Center(child: TitlePage(title: 'Surat Permohonan Riset')),
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
                      controller: judulTAController,
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

                    SizedBox(height: 10),
                    const Text(
                      'Tempat Penelitian',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SiakColors.SiakBlack, backgroundColor: SiakColors.SiakPrimaryLightColor),
                    ),
                    const  SizedBox(height: 10,),
                    TextField(
                      controller: tempatPenelitianController,
                      maxLines: 2,
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
                      'Alamat Penelitian',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SiakColors.SiakBlack, backgroundColor: SiakColors.SiakPrimaryLightColor),
                    ),
                    const  SizedBox(height: 10,),
                    TextField(
                      controller: alamatPenelitianController,
                      maxLines: 3,
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

                    SizedBox(height: 10),



                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child:
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

              ),
            ],
          ),
        ),
      ),
    );
  }
}
