import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:siak/model/siak_models/transkrip_model.dart';
import 'package:siak/theme/app_style.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';

class SiakTranskrip extends StatefulWidget {


  const SiakTranskrip({key,});

  @override
  State<SiakTranskrip> createState() => _SiakTranskripState();
}

class _SiakTranskripState extends State<SiakTranskrip> {

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


  Future<List<TranskripNilai>> _loadTranskripDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchTranskrip(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final transkripNilaiModel = TranskripModel.fromJson(data);
        return transkripNilaiModel.transkripNilai;
      } else {
        // Data kosong, kembalikan list kosong
        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
        return [];
      }
    } else {
      // Token tidak ada atau kosong, kembalikan list kosong
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return [];
    }
  }


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
    _loadTranskripDataFromServer();
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
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TitlePage(title: 'Transkrip Sementara'),
              )),

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
      TextField(
        controller: _searchController,
        decoration:
        InputDecoration(
          hintText: 'Cari berdasarkan nama atau kode mata kuliah atau nama mata kuliah',
          prefixIcon: Icon(Icons.search, color: SiakColors.SiakPrimary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: SiakColors.SiakPrimary),
            borderRadius: BorderRadius.circular(20.0), // Atur radius sesuai keinginan
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: SiakColors.SiakPrimary), // Berikan border ketika TextField dalam keadaan fokus
            borderRadius: BorderRadius.circular(20.0), // Atur radius sesuai keinginan
          ),
        ),
        onChanged: (value) {
          // Ketika isi search bar berubah, lakukan pencarian ulang
          setState(() {});
        },
      ),


              const SizedBox(height: 20,),


              FutureBuilder<List<TranskripNilai>>(
                future: _loadTranskripDataFromServer(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Sedang memuat data
                    return const Center(
                      child: LinearProgressIndicator(color: SiakColors.SiakPrimary,),
                    );
                  } else if (snapshot.hasError) {
                    // Terjadi error saat memuat data
                    return Center(
                      child: Text('Terjadi kesalahan saat memuat data', style: AppStyle.txtPoppinsMedium16,),
                    );
                  } else if (snapshot.hasData) {
                    // Data berhasil dimuat
                    List<TranskripNilai> transkripList = snapshot.data!;

                    // Lakukan pencarian berdasarkan kode mata kuliah dan nama mata kuliah
                    String keyword = _searchController.text.toLowerCase();
                    _filteredTranskripList = transkripList.where((transkrip) {
                      String kodeMatkul = transkrip.kdMatkul.toLowerCase();
                      String namaMatkul = transkrip.nmMatkul.toLowerCase();
                      return kodeMatkul.contains(keyword) || namaMatkul.contains(keyword);
                    }).toList();

                    if (_filteredTranskripList.isEmpty) {
                      // Tidak ada data yang ditemukan
                      return Center(
                        child: Column(
                          children: [
                            Container(child: Image.asset(notifkosong, height: 100, width: 100)),
                            Column(
                              children:  [
                                Center(
                                  child: Text(
                                    'Data tidak ditemukan',
                                    style: AppStyle.txtPoppinsMedium16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      // Tampilkan data yang ditemukan
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _filteredTranskripList.length,
                        itemBuilder: (context, index) {
                          final transkripNilai = _filteredTranskripList[index];
                          return SiakCardTranskrip(transkripNilai: transkripNilai);
                        },
                      );
                    }
                  } else {
                    // Tidak ada data yang ditemukan
                    return Center(
                      child: Column(
                        children: [
                          Container(child: Image.asset(notifkosong, height: 100, width: 100)),
                          Row(
                            children: const [
                              Text(
                                'Belum ada data transkrip',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: 30,)

            ],
          ),
        ),
      ),
      floatingActionButton: FutureBuilder<TranskripModel?>(
        future: _getDatauserTranskrip(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Sedang memuat data
            return FloatingActionButton.extended(
              onPressed: () {},
              label: Column(
                children: const [
                  CircularProgressIndicator(), // Tampilkan indikator loading
                  Text('Loading...'),
                ],
              ),
              icon: Icon(Icons.bar_chart),
              backgroundColor: SiakColors.SiakGreenDark.withAlpha(250),
            );
          } else if (snapshot.hasError) {
            // Terjadi error saat memuat data
            return FloatingActionButton.extended(
              onPressed: () {},
              label: Column(
                children: [
                  Icon(Icons.error), // Tampilkan ikon error

                  Text('Error: ${snapshot.error}'),
                ],
              ),
              icon: Icon(Icons.bar_chart),
              backgroundColor: SiakColors.SiakGreenDark.withAlpha(250),
            );
          } else {
            // Data berhasil dimuat
            _trans = snapshot.data;
            return FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
              },
              label: Column(
                children: [
                  Text("IPK : ${_trans?.user.ipk.toString() ?? ''}"),
                  Text("+SKS : ${_trans?.user.totalSks.toString() ?? ''}"),
                ],
              ),
              icon: Icon(Icons.bar_chart),
              backgroundColor: SiakColors.SiakBlack.withAlpha(190),
            );
          }
        },
      ),

      bottomSheet: SiakBottomSheet(),
    );
  }
}
