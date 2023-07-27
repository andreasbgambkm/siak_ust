import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/siak_models/absensi_model.dart';
import 'package:siak/model/siak_models/rincian_absensi.dart';
import 'package:siak/screen/absensi/isi_absensi/isi_absensi.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/custom_indicator.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:fl_chart/fl_chart.dart';


class SiakRincianAbsensi extends StatefulWidget {
  final String? idJadwal;
  final String? namaMatkul;
  final String? kdMatkul;

  const SiakRincianAbsensi({Key? key, this.idJadwal, this.namaMatkul, this.kdMatkul}) : super(key: key);

  @override
  State<SiakRincianAbsensi> createState() => _SiakRincianAbsensiState();
}

class _SiakRincianAbsensiState extends State<SiakRincianAbsensi> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<RegistrasiElement> registrasiList = [];
  String? _registrasiLastest;
  bool isAllActive = false;
  Registrasi? _reg;
  List<RincianAbsensi?> _rincianAbsensiMataKuliahList = [];
  RincianAbsensi? rincianAbsensi;


  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadRegistrasiDataFromLocal();
    _loadRincianAbsensiPertemuanFromServer();


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


  Future<List<AbsensiPertemuan?>> _loadRincianAbsensiPertemuanFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchDataRincianAbsensi(token, widget.idJadwal.toString());

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final rincianAbsen = RincianAbsensi.fromJson(data);
        return rincianAbsen.absensi_pertemuan;
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
      body: FutureBuilder<List<AbsensiPertemuan?>>(
        future: _loadRincianAbsensiPertemuanFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {

            final absensi = snapshot.data!;
            print('cek isi data snapshot');
            print(absensi);
            return absensi.isEmpty ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(notifkosong, height: 100, width: 100),
                  SizedBox(height: 16),
                  const Text(
                    'Belum Ada Data Absensi',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

            ): SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          TitlePage(
                            title: 'Rincian Absensi Mahasiswa',
                          ),



                          const SizedBox(height: 10),

                          SiakCard(
                            shadow: 2,
                            child: Column(
                              children:<Widget> [
                                Table(
                                  defaultColumnWidth:
                                  FixedColumnWidth(MediaQuery.of(context).size.width / 2.5),
                                  border: TableBorder.all(
                                    color: Colors.transparent,
                                    style: BorderStyle.solid,
                                  ),
                                  children: [
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
                                                "Semester :",
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

                          SizedBox(height: 30,),


                          Padding(
                            padding: EdgeInsets.only(left:10, right: 10 ),
                            child: Container(
                              color: Colors.yellow.shade200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    " ${widget.kdMatkul}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: SiakColors.SiakPrimary,
                                    ),
                                  ),
                                  Text(
                                    " ${widget.namaMatkul}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: SiakColors.SiakBlack,
                                    ),
                                  ),



                                ],
                              ),
                            ),
                          ),

                SizedBox(height: 20,),


                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Radius untuk melengkungkan sudut Card
                    side: BorderSide(color: Colors.black, width: 0.5), // Border di sekeliling Card
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DataTable(
                                columnSpacing: 16,
                                columns:  [
                                  DataColumn(label: Text("Tanggal", style: GoogleFonts.openSans(color: SiakColors.SiakPrimary),)),
                                  DataColumn(label: Text("Hari" , style: GoogleFonts.openSans(color: SiakColors.SiakPrimary),)),
                                  DataColumn(label: Text("Ruangan", style: GoogleFonts.openSans(color: SiakColors.SiakPrimary),)),
                                  DataColumn(label: Text("Status", style: GoogleFonts.openSans(color: SiakColors.SiakPrimary),)),
                                ],
                                rows: List.generate(
                                  absensi.length,
                                      (index) => DataRow(
                                    cells: [
                                      DataCell(Text("${absensi[index]?.tgl}")),
                                      DataCell(Text("${absensi[index]?.hari.toString()}")),
                                      DataCell(Text("${absensi[index]?.ruangan.toString()}")),
                                      DataCell(Text("${absensi[index]?.status.toString()}")),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),

                )







                        ],
                      ),
                    ),



                  ],
                ),
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


}
