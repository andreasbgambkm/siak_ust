import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';
import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:siak/model/siak_models/transkrip_model.dart';


class SiakRekapAngket extends StatefulWidget {
  const SiakRekapAngket({Key? key}) : super(key: key);

  @override
  State<SiakRekapAngket> createState() => _SiakRekapAngketState();
}

class _SiakRekapAngketState extends State<SiakRekapAngket> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<RegistrasiElement> registrasiList = [];
  String? _registrasiLastest;
  bool isAllActive = false;
  Registrasi? _reg;
  TranskripModel? _trans;
  UserTranskrip? _transUser;

  List<TranskripNilai> _filteredTranskripList = [];
  TextEditingController _searchController = TextEditingController();
  Future<TranskripModel?> _getDatauserTranskrip() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      // Periksa apakah data profil sudah ada dalam preferences
      final storedProfile = prefs.getString('userTranskrip');
      if (storedProfile != null && storedProfile.isNotEmpty) {
        // Jika data profil sudah ada, langsung kembalikan objek ProfileMahasiswa
        return TranskripModel.fromJson(jsonDecode(storedProfile));
      } else {
        final data = await _databaseHelper.fetchTranskrip(token);
        print(data);

        if (data != null && data.isNotEmpty) {
          // Konversi Map<String, dynamic> menjadi JSON string
          final jsonData = jsonEncode(data);

          // Simpan data ke dalam SharedPreferences
          await prefs.setString('userTranskrip', jsonData);

          return TranskripModel.fromJson(data);
        } else {
          // Data kosong, kembalikan nilai null
          Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
          return null;
        }
      }
    } else {
      // Token tidak ada atau kosong, kembalikan nilai null
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return null;
    }
  }


  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadRegistrasiDataFromLocal();
    _getDatauserTranskrip();


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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TitlePage(title: 'Review Angket'),
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

              const SizedBox(height: 20),
              // Menu Nilai UTS, UAS, dan Angket menggunakan GridView


              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      // ... Kode lainnya ...
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
