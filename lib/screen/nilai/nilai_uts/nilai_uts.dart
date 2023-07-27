import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/siak_models/nilai_uts_model.dart';
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

class SiakNilaiUts extends StatefulWidget {
  const SiakNilaiUts({Key? key}) : super(key: key);

  @override
  State<SiakNilaiUts> createState() => _SiakNilaiUtsState();
}

class _SiakNilaiUtsState extends State<SiakNilaiUts> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<RegistrasiElement> registrasiList = [];
  String? _registrasiLastest;
  bool isAllActive = false;
  Registrasi? _reg;

  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadRegistrasiDataFromLocal();
    _loadNilaiUtsDataFromServer();


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

  Future<List<NilaiElement?>> _loadNilaiUtsDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchNilaiUts(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final utsModel = NilaiUTSModel.fromJson(data);
        return utsModel.nilai;
      } else {

        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
        return [];
      }
    } else {
      // Token tidak ada atau kosong, kembalikan list kosong
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return [];
    }
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
      body: FutureBuilder<List<NilaiElement?>>(
        future: _loadNilaiUtsDataFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {

            final nilaiUts = snapshot.data!;
            print('cek isi data snapshot');
            print(nilaiUts);
            return nilaiUts.isEmpty ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(notifkosong, height: 100, width: 100),
                  SizedBox(height: 16),
                  const Text(
                    'Belum Ada Nilai Uts',
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
                        TitlePage(
                          title: 'Nilai Uts',
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
                            itemCount: nilaiUts.length,
                            itemBuilder: (context, index) {

                              print(nilaiUts);
                              final uts = nilaiUts[index];

                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Radius untuk melengkungkan sudut Card
                                  side: BorderSide(color: Colors.black, width: 1.0), // Border di sekeliling Card
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: Colors.yellow.shade200,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${uts?.kdMatkul}   ",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: SiakColors.SiakPrimary,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${uts?.nmMatkul}   ",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),



                                                    ],
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),



                                        ],
                                      ),

                                      Row(
                                        children: [
                                          DataTable(
                                            columnSpacing: 16,
                                            columns: [
                                              DataColumn(label: Text("SKS")),
                                              DataColumn(label: Text("Nilai Uts")),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Center(child: Text("${uts?.sks.toString()}", style: GoogleFonts.poppins(color: SiakColors.SiakPrimary)))),
                                                DataCell(Center(child: Text("${uts?.nUTS.toString()}", style: GoogleFonts.poppins(color: SiakColors.SiakPrimary),))),

                                              ]),
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

    );
  }
  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.8), // Mengatur warna card dengan sedikit transparansi
          borderRadius: BorderRadius.circular(10), // Mengatur corner radius card
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ], // Menambahkan shadow card

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
