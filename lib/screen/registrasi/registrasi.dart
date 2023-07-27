import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakRegistrasi extends StatefulWidget {
   SiakRegistrasi({key, this.profileNama, this.profileNpm});

  String? profileNama;
  String? profileNpm;

  @override
  State<SiakRegistrasi> createState() => _SiakRegistrasiState();
}

class _SiakRegistrasiState extends State<SiakRegistrasi> {
  DatabaseHelper _dbhelper = DatabaseHelper();
  Registrasi? _reg;
  ProfileMahasiswa? _profileMahasiswa;
  List<RegistrasiElement> registrasiList = [];
  bool isAllActive = false;



  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadRegistrasiDataFromLocal();

    print(registrasiList);
  }

  Future<void> _loadRegistrasiDataFromLocal() async {
    Registrasi? registrasi = await _dbhelper.getDataRegistrasiFromPreferences();
    print(registrasi);

    setState(() {

      _reg = registrasi;

      registrasiList = registrasi?.registrasi_element ?? [];
    });
  }
  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profilemhs = await _dbhelper.getProfileDataFromPreferences();


    setState(() {

      _profileMahasiswa = profilemhs;
      // Cek apakah semua status adalah "1"
      isAllActive = registrasiList.every((element) => element.status == "1");
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: TitlePage(title: 'REGISTRASI MAHASISWA',)),
            Container(

              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                      color: Color.fromARGB(255, 201, 201, 201), width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 201, 201, 201),
                        offset: Offset(4, 4)),
                  ]),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/2.35),
                border: TableBorder.all(
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Nama",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(": ${_profileMahasiswa?.nama}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Npm",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(": ${_profileMahasiswa?.npm}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Program Studi",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(": ${_reg?.userreg.prodi}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Status",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, ),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Text(isAllActive ? ": Aktif" : ": Belum Registrasi",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),

                        ),
                      )
                    ]),
                  ]),



                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: registrasiList.length,
                itemBuilder: (context, index) {
                  final registrasiElement = registrasiList[index];
                  return SiakCardRegistrasi(
                    no_daftar: registrasiElement.noDaftar,
                    tahun_ajaran: registrasiElement.thnAjaran,
                    tanggal_registrasi: registrasiElement.tglRegistrasi,
                    status: registrasiElement.status,);


                },

              ),
            ),

          ],
        ),
      ),
      bottomSheet: SiakBottomSheet(),
    );
  }
}