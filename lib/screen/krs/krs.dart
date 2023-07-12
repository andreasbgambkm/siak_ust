import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/button.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakKRS extends StatefulWidget {
  final String? profileNama;
  final String? profileNPM;
  final String? programStudi;

  SiakKRS({this.profileNama, this.profileNPM, this.programStudi});

  @override
  State<SiakKRS> createState() => _SiakKRSState();
}

class _SiakKRSState extends State<SiakKRS> {
  ProfileMahasiswa? _profileData;
  DatabaseHelper _getProfile = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _getData();
    print(_getData());
  }

  Future <void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final data = await _getProfile.fetchProfileMahasiswa(token);
      if (data != null) {
        setState(() {
          _profileData = ProfileMahasiswa.fromJson(data);
        });
      } else {
        print('Gagal mendapatkan data profil');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SiakDrawer(context: context,profileNama: widget.profileNama, profileNpm: widget.profileNPM.toString()),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TitlePage(
                title: 'Kartu Rencana Studi',
              ),
            ),
            SiakCard(
              shadow: 2,
              child: Table(
                defaultColumnWidth:
                FixedColumnWidth(MediaQuery.of(context).size.width / 2.35),
                border: TableBorder.all(
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Nama",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("${widget.profileNama}",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "NPM",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${widget.profileNPM}",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "PROGRAM STUDI",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "SISTEM INFORMASI",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "SEMESTER BERJALAN",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "6",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "IP SEMESTER LALU",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "4.0",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "MAKSIMUM SKS",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "24",
                          style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: SiakButton(
                  widthButton: 90,
                  text: 'ISI KRS',
                  borderRadius: 8,
                  heightButton: 40,
                  onPressedButton: () {
                    Navigator.of(context).pushNamed("/IsiKRSPage");
                  },
                )),
            SizedBox(
              height: 10,
            ),
            SiakCard(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: SiakColors.SiakPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Download/Cetak KRS',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Pilih KRS Yang Ingin Dicetak',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 40,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 224, 224, 224),
                      ),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        alignment: Alignment.center,
                        hint: Text(
                          "PILIH KRS",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                        ),
                        items: <String>[
                          '2021/2022 - GENAP',
                          '2021/2022 - GANJIL',
                          '2020/2021 - SP',
                          '2020/2021 - GENAP',
                          '2020/2021 - GANJIL',
                          '2019/2020 - SP',
                          '2019/2020 - GENAP',
                          '2019/2020 - GANJIL'
                        ].map((String value) {
                          return DropdownMenuItem<String>(

                            alignment: AlignmentDirectional.centerStart,
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: MediaQuery.of(context).size.width / 1.5,
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                value,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {},
                      ),
                    ),
                  ],
                ),
                shadow: 2),
            Footer()
          ],
        ),
      ),
    );
  }
}
