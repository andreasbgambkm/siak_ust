import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/isi_krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/nilai_uas_model.dart';
import 'package:siak/screen/suratpermohonan/sp.dart';
import 'package:siak/screen/suratpermohonan/surat_aktif/preview_surat_aktif/preview_surat_aktif.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/title.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SiakComplain extends StatefulWidget {
  @override
  State<SiakComplain> createState() => _SiakComplainState();
}

class _SiakComplainState extends State<SiakComplain> {
  ProfileMahasiswa? _profileMahasiswa;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  TextEditingController alasanController = TextEditingController();
  dynamic token;
  bool isSendingData = false;
  List<NilaiUasElement> mata_kuliah = [];
  NilaiUASModel? _mataKuliah;
  NilaiUasElement? selectedValue;

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

  Future<void> _loadKomplainMataKuliahDataFromLocal() async {
    NilaiUASModel? komplainMataKuliah = await _databaseHelper.getNilaiUasDataFromPreferences();

    setState(() {
      _mataKuliah = komplainMataKuliah;
      mata_kuliah = komplainMataKuliah?.nilai ?? [];

      print("Jumlah mata_kuliah: ${mata_kuliah.length}");
      for (var mataKuliah in mata_kuliah) {
        print("Mata Kuliah: ${mataKuliah.nmMatkul}, ID Jadwal: ${mataKuliah.id}");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadTokenDataFromPreferences();
    _loadKomplainMataKuliahDataFromLocal();
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

    String alasan = alasanController.text;

    if (alasan.isEmpty) {
      _showErrorDialog('Anda Belum Mengisi Alasan.');
      setState(() {
        isSendingData = false;
      });
      return;
    } else{
      await _databaseHelper.postComplain(alasan, selectedValue?.id.toString(), token);

      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(
        max: 100,
        msg: 'Memproses Komplain...',
        progressType: ProgressType.valuable,
      );
      pd.close();




      Fluttertoast.showToast(msg: 'Komplain Berhasil Dikirim!', toastLength: Toast.LENGTH_SHORT);


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
            Navigator.of(context).pushReplacementNamed("/NilaiPage");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitlePage(title: 'Komplain'),
              SizedBox(height: 20),

              SPWelcomingCard(nama: _profileMahasiswa?.nama , height: 120, msg: "Silahkan Isi Komplain Anda Disini",),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Table(
                      defaultColumnWidth:
                      FixedColumnWidth(MediaQuery.of(context).size.width / 2.35),
                      border: TableBorder.all(
                        color: Colors.transparent,
                        style: BorderStyle.solid,
                      ),
                      children: [
                        TableRow(
                          children: [
                            Column(
                              children:<Widget> [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Nama",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    ": ${_profileMahasiswa?.nama}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Npm",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    ": ${_profileMahasiswa?.npm}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Program Studi",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    ": ${_profileMahasiswa?.prodi}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Mata Kuliah ",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: DropdownButton<NilaiUasElement>(
                                      value: selectedValue,
                                      menuMaxHeight: 150,
                                      focusColor: SiakColors.SiakBlack,
                                      icon: Icon(Icons.arrow_drop_down, color: SiakColors.SiakBlack, size: 20,),
                                      onChanged: (NilaiUasElement? newValue) {
                                        setState(() {
                                          selectedValue = newValue;
                                        });
                                      },
                                      items: mata_kuliah.map((NilaiUasElement mataKuliah) {
                                        return DropdownMenuItem<NilaiUasElement>(
                                          value: mataKuliah,
                                          child: Text(
                                            mataKuliah.nmMatkul,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: SiakColors.SiakPrimary,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),



                      ],
                    ),
                    SizedBox(height: 20),

                    const Text(
                      'Alasan :',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: 6,
                      controller: alasanController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakBlack),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakBlack),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: SiakColors.SiakBlack),
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
