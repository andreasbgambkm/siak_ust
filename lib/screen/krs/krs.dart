import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/screen/krs/isi_krs_page/isi_krs.dart';
import 'package:siak/screen/krs/krs_diambil_page/krs_diambil.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';

class SiakKRS extends StatefulWidget {

  final int totalSKSAmbil;
  const SiakKRS({super.key, this.totalSKSAmbil = 0});




  @override
  State<SiakKRS> createState() => _SiakKRSState();
}

class _SiakKRSState extends State<SiakKRS> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<Combobox> comboKrsList = [];
  Combobox? selectedKrs;

  dynamic token;



  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadTokenDataFromPreferences();
    print('cek konstruktor');
    print(widget.totalSKSAmbil);
  }

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile =
    await _databaseHelper.getProfileDataFromPreferences();

    setState(() {
      _profileMahasiswa = profile;
    });
  }

  Future<void> _loadKrsDataFromLocal() async {
    Krs? krs = await _databaseHelper.getKrsDataFromPreferences();
    setState(() {
      _krs = krs;
      comboKrsList = krs?.combobox ?? [];
      selectedKrs = comboKrsList.isNotEmpty ? comboKrsList[0] : null;
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Center(
                child: TitlePage(
                  title: 'Kartu Rencana Studi',
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
                                    "IP Semester Lalu",
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
                                    ": ${_krs?.user.ipSemesterSebelum}",
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
                                    "Maksimum SKS",
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
                                    ": ${_krs?.user.maksSks}",
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

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    _getCardItem(icon: Icons.featured_play_list_sharp, labelTitle: 'Isi Krs\n Anda', labelSubTitle: 'Isi Krs', color: SiakColors.SiakPrimary,
                      onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => SiakIsiKRS(totalSKSTelahDiambil: widget.totalSKSAmbil,)),);}, ),

                    const Spacer(),
                    _getCardItem(icon: Icons.visibility, labelTitle: 'Lihat Krs\nYang Diambil', labelSubTitle: 'Krs Diambil',
                      color: SiakColors.SiakPrimary,
                      onPressed: () {   Navigator.push(context, MaterialPageRoute(builder: (context) => SiakKRSDiambil()),);}, ),

                  ],
                )
              ),


              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0, ),
                child: Container(
                  height: MediaQuery.of(context).size.height/0.8,
                  child: Column(
                    children:<Widget> [


                      SPWelcomingCard(nama: _profileMahasiswa?.nama , height: 190, msg: "Silahkan pilih KRS yang ingin dicetak",),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(

                            color: SiakColors.SiakPrimaryLightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Download/Cetak KRS',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: SiakColors.SiakBlack,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: comboKrsList.length,
                          itemBuilder: (context, index) {
                            final krsList = comboKrsList[index];
                            return SiakCardRiwayatKRS(
                                token: token,
                                id_krs: krsList.id,
                                tahun_ajaran: krsList.tahunAjaran,
                                semester: krsList.semester);
                          },

                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      bottomSheet: SiakBottomSheet(),
    );
  }

  Widget _getCardItem({
    required IconData icon,
    required String labelTitle,
    required String labelSubTitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: SiakColors.SiakWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Icon(icon, size: 24, color: SiakColors.SiakPrimary),
                    padding: const EdgeInsets.all(12),
                  ),
                  Container(
                    child: Text(
                      labelTitle,
                      style: TextStyle(
                        color: SiakColors.SiakPrimary,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  color: SiakColors.SiakPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    labelSubTitle,
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: SiakColors.SiakWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
