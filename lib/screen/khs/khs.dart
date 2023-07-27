import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/khs_model.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/button.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakKHS extends StatefulWidget {



  @override
  State<SiakKHS> createState() => _SiakKHSState();
}

class _SiakKHSState extends State<SiakKHS> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;

  List<ComboboxKhs> comboKhsList = [];
  ComboboxKhs? selectedKhs;

  dynamic token;

  KhsModel? _khs;

  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKhsDataFromLocal();
    _loadTokenDataFromPreferences();
  }

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile =
    await _databaseHelper.getProfileDataFromPreferences();

    setState(() {
      _profileMahasiswa = profile;
    });
  }

  Future<void> _loadKhsDataFromLocal() async {
    KhsModel? khs = await _databaseHelper.getKhsDataFromPreferences();
    setState(() {
      _khs = khs;
      comboKhsList = khs?.combobox ?? [];
      selectedKhs = comboKhsList.isNotEmpty ? comboKhsList[0] : null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SiakDrawer(context: context),
      appBar: SiakAppbar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: TitlePage(
                        title: 'Kartu Hasil Studi',
                      ),
                    ),
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
                                          "Fakultas",
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
                                          ": ${_profileMahasiswa?.fakultas}",
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
                                          ": ${_khs?.user.prodi}",
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


                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height/0.8,
                        child: Column(
                          children:<Widget> [

                            const SizedBox(height: 10),

                            SPWelcomingCard(nama: _profileMahasiswa?.nama , height: 190, msg: "Silahkan pilih KHS :)",),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(

                                  color: SiakColors.SiakPrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Lihat KHS',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: SiakColors.SiakWhite,
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: comboKhsList.length,
                              itemBuilder: (context, index) {
                                final khsList = comboKhsList[index];
                                print(khsList.id);
                                return SiakCardRiwayatKHS(comboboxKhs: khsList, token: token,
                                    );
                              },

                            ),
                          ],
                        ),
                      ),
                    ),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomSheet: SiakBottomSheet(),
    );
  }
}
