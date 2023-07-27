import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/siak_models/nilai_uas_model.dart';
import 'package:siak/screen/nilai/angket/isi_angket/isi_angket.dart';
import 'package:siak/screen/nilai/complain/complain.dart';

import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/title.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:siak/model/siak_models/transkrip_model.dart';


class SiakNilaiUas extends StatefulWidget {
  const SiakNilaiUas({Key? key}) : super(key: key);

  @override
  State<SiakNilaiUas> createState() => _SiakNilaiUasState();
}

class _SiakNilaiUasState extends State<SiakNilaiUas> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<RegistrasiElement> registrasiList = [];
  String? _registrasiLastest;
  bool isAllActive = false;
  Registrasi? _reg;
  bool _isModalOpen = false;


  @override
  void initState() {
    super.initState();
    _loadNilaiUasDataFromServer();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadRegistrasiDataFromLocal();


  }

  Future<List<NilaiUasElement?>> _loadNilaiUasDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchNilaiUAS(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final uasModel = NilaiUASModel.fromJson(data);
        final jsonData = jsonEncode(data);
        prefs.setString('uas', jsonData);
        return uasModel.nilai;
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
        return [];
      }
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return [];
    }
  }



  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _databaseHelper.getProfileDataFromPreferences();

    setState(() {
      _profileMahasiswa = profile;
    });
  }
  Future<void> _loadKrsDataFromLocal() async {
    Krs? krs = await _databaseHelper.getKrsDataFromPreferences();
    setState(() {
      _krs = krs;

    });
  }
  Future<void> _loadRegistrasiDataFromLocal() async {
    Registrasi? registrasi = await _databaseHelper.getDataRegistrasiFromPreferences();
    print(registrasi);

    setState(() {

      _reg = registrasi;

      registrasiList = registrasi?.registrasi_element ?? [];

      if (registrasiList.isNotEmpty) {
        setState(() {
          RegistrasiElement registrasiLastest = registrasiList.last;
          _registrasiLastest = registrasiLastest.thnAjaran;
        });
      } else {
        setState(() {
          _registrasiLastest = "List registrasiList kosong.";
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(),
      bottomSheet: SiakBottomSheet(),

      body: FutureBuilder<List<NilaiUasElement?>>(
        future: _loadNilaiUasDataFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {

            final nilaiUas = snapshot.data!;
            print('cek isi data snapshot');
            print(nilaiUas);
            return nilaiUas.isEmpty ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(notifkosong, height: 100, width: 100),
                  SizedBox(height: 16),
                  const Text(
                    'Belum Ada Nilai Uas',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

            ): SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        const TitlePage(
                          title: 'Nilai UAS',
                        ),



                        const SizedBox(height: 10),

                        SiakCard(
                          shadow: 2,
                          child: Column(
                            children:<Widget> [
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
                                              ": ${_krs?.user.prodi}",
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
                                              "Semester Berjalan",
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
                                              ": ${_krs?.user.semesterBerjalan}",
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
                                              "Tahun Ajaran",
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
                                              ": ${_registrasiLastest}",
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

                                ],
                              ),
                              const SizedBox(height: 10),

                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left:15, top: 10 ),
                          child: Text(
                            'Daftar Nilai',
                            style: TextStyle(
                                color:  SiakColors.SiakPrimary ,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: nilaiUas.length,
                            itemBuilder: (context, index) {

                              print(nilaiUas);
                              final uas = nilaiUas[index];

                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Radius untuk melengkungkan sudut Card
                                  side: BorderSide(color: Colors.black, width: 1.0), // Border di sekeliling Card
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.yellow.shade200,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${uas?.kdMatkul} ${uas?.nmMatkul}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: SiakColors.SiakPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          DataTable(
                                            columnSpacing: 16,
                                            columns: [
                                              DataColumn(label: Text("SKS")),
                                              DataColumn(label: Text("Nilai Akhir")),
                                              DataColumn(label: Text("Nilai Huruf")),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Center(child: Text("${uas?.sks.toString()}", style: GoogleFonts.poppins(color: SiakColors.SiakPrimary)))),
                                                DataCell(Center(child: Text("${uas?.nUAS}", style: GoogleFonts.poppins(color: SiakColors.SiakPrimary),))),
                                                DataCell(Center(child: Text("${uas?.nilaiHuruf}", style: GoogleFonts.poppins(color: SiakColors.SiakPrimary))),
                                                ),
                                              ]),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                child: TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          ),
                                                          title: Text(
                                                            "Rincian Nilai",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18,
                                                              color: SiakColors.SiakPrimary,
                                                            ),
                                                          ),
                                                          content: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              _buildRichText("Nilai Sikap", "${uas?.nSK}"),
                                                              _buildRichText("Nilai Tugas", "${uas?.nTugas}"),
                                                              _buildRichText("Nilai UTS", "${uas?.nUTS}"),
                                                              _buildRichText("Nilai UAS", "${uas?.nUAS}"),
                                                              _buildRichText("Nilai Akhir", "${uas?.nAngka}"),

                                                            ],
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {

                                                                Navigator.of(context).pop();
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                primary: SiakColors.SiakPrimary,
                                                                onPrimary: SiakColors.SiakWhite,
                                                              ),
                                                              child: const Text("Tutup"),
                                                            )

                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                        size: 16,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text("Rincian"),
                                                    ],
                                                  ),
                                                ),
                                              ),




                                              Container(
                                                child: TextButton(
                                                  onPressed: (uas?.statusAngket == 1 || uas?.statusAngket == "1")
                                                      ? null
                                                      : () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => SiakIsiAngket(kdMatkul: uas?.kdMatkul)),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    // Ganti warna tombol menjadi abu-abu jika tombol dinonaktifkan
                                                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                          (states) {
                                                        if (states.contains(MaterialState.disabled)) {
                                                          return SiakColors.gray100;
                                                        }
                                                        return Colors.transparent; // Biarkan warna default tombol aktif
                                                      },
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: const [
                                                      Icon(
                                                        Icons.edit,
                                                        size: 16,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text("Angket"),
                                                    ],
                                                  ),
                                                ),
                                              )



                                            ],
                                          ),


                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              );

                            },

                          ),
                        ),




                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              title: Column(
                                children: const [
                                  Text(
                                    "Perhatian !",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: SiakColors.SiakPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(
                                    "Dengan mengajukan komplain, anda sangat memahami bahwa terjadi permasalahan pada nilai anda !?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: SiakColors.SiakBlack,
                                    ),
                                  ),
                                ],
                              ),

                              actions: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(

                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: SiakColors.SiakPrimary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              SizedBox(width: 8),
                                              Text('Batal'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8,),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => SiakComplain()),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: SiakColors.SiakPrimary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              SizedBox(width: 8),
                                              Text('Lanjutkan'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            );
                          },
                        );
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
                          Icon(Icons.pan_tool),
                          SizedBox(width: 8),
                          Text('Ajukan Komplain'),
                        ],
                      ),
                    ),
                  ),




                ],
              ),
            );
          } else if (snapshot.hasError) {
            // Tangani error, misalnya dengan menampilkan pesan error
            return Text('Error: ${snapshot.error}');
          } else {
            // Data null atau kemungkinan kondisi lain yang tidak diharapkan
            return Text('Terjadi kesalahan.');
          }
        },
      ),
      // ... Kode lainnya ...
    );
  }
  Widget _buildRichText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$label ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),



              ],
            ),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [

                TextSpan(
                  text: ": $value",
                  style: TextStyle(
                    color: SiakColors.SiakPrimary, fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
