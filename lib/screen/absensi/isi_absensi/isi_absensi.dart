import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/siak_models/rincian_absensi.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/custom_indicator.dart';
import 'package:siak/widgets/title.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:fl_chart/fl_chart.dart';


class SiakIsiAbsensi extends StatefulWidget {


  final String? idJadwal;
  final String? namaMatkul;
  const SiakIsiAbsensi({Key? key, required this.idJadwal, required this.namaMatkul}) : super(key: key);


  @override
  State<SiakIsiAbsensi> createState() => _SiakIsiAbsensiState();
}

class _SiakIsiAbsensiState extends State<SiakIsiAbsensi> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<RegistrasiElement> registrasiList = [];
  String? _registrasiLastest;
  bool isAllActive = false;
  Registrasi? _reg;
  List<RincianAbsensi?> _rincianAbsensiMataKuliahList = [];
  RincianAbsensi? rincianAbsensi;
  String? selectedAbsenType = 'H';
  dynamic token;


  @override
  void initState() {
    super.initState();
    _loadRincianAbsensiPertemuanFromServer();
    _loadTokenDataFromPreferences();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadRegistrasiDataFromLocal();
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
  double calculatePercentage(int hadir, int alpha, int ijin, int sakit) {
    int totalAbsensi = hadir + alpha + ijin + sakit;
    double presentase = (hadir / totalAbsensi) * 100;
    return presentase;
  }
  Widget createPieChart(int hadir, int alpha, int ijin, int sakit) {
    double presentaseHadir = calculatePercentage(hadir, alpha, ijin, sakit);
    double presentaseAlpha = calculatePercentage(alpha, hadir, ijin, sakit);
    double presentaseIjin = calculatePercentage(ijin, hadir, alpha, sakit);
    double presentaseSakit = calculatePercentage(sakit, hadir, alpha, ijin);

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: [
          const SizedBox(height: 18,),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 5,
                  centerSpaceRadius: 60,
                  sections: [
                    PieChartSectionData(
                      value: presentaseHadir,
                      color: Colors.green,
                      title: '${presentaseHadir.toStringAsFixed(2)}%',
                      radius: 40,
                      titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    PieChartSectionData(
                      value: presentaseAlpha,
                      color: SiakColors.SiakPrimary.withAlpha(100),
                      title: '${presentaseAlpha.toStringAsFixed(2)}%',
                      radius: 36,
                      titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    PieChartSectionData(
                      value: presentaseIjin,
                      color: Colors.orange,
                      title: '${presentaseIjin.toStringAsFixed(2)}%',
                      radius: 32,
                      titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    PieChartSectionData(
                      value: presentaseSakit,
                      color: SiakColors.SiakBlueLight,
                      title: '${presentaseSakit.toStringAsFixed(2)}%',
                      radius: 28,
                      titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                    ),


                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Indicator(
                color: Colors.green,
                text: 'Hadir',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: SiakColors.SiakPrimary.withAlpha(100),
                text: 'Alpha',
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              const Indicator(
                color: Colors.orange,
                text: 'Ijin',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: SiakColors.SiakBlueLight,
                text: 'Sakit',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),


    );


  }
  showAlertDialog(BuildContext context, int hadir, int alpha, int ijin, int sakit) {
    Widget pieChart = createPieChart(hadir, alpha, ijin, sakit);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Persentase Absensi', style: GoogleFonts.poppins(
                fontStyle: FontStyle.italic,
                color: SiakColors.SiakPrimary,
                fontSize: 18,
                fontWeight:
                FontWeight.bold),),
          ),
          content: Container(
            padding: EdgeInsets.all(0),
            width: 300,
            height: 300,
            child: pieChart,
          ),
          actions: [
            Center(
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
                    Text('Tutup'),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/AbsensiPage");
          },
        ),
      ),
      bottomSheet: SiakBottomSheet(),
      body: FutureBuilder<List<AbsensiPertemuan?>>(
        future: _loadRincianAbsensiPertemuanFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {

            final rincian_absensi = snapshot.data!;
            print('cek isi data snapshot');
            print(rincian_absensi);
            return rincian_absensi.isEmpty ? Center(
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
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        TitlePage(
                          title: 'Pengisian Absensi',
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(


                            children: [
                              Expanded(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      color: Colors.yellow.shade200,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(

                                            widget.namaMatkul.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: SiakColors.SiakBlack,
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
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left:15, top: 10 ),
                          child: Text(
                            'Daftar Absensi Pertemuan',
                            style: TextStyle(
                                color:  SiakColors.SiakPrimary ,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),


                        SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: rincian_absensi.length,
                            itemBuilder: (context, index) {

                              print(rincian_absensi);
                              final rincian_absensi_mahasiswa = rincian_absensi[index];

                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Radius untuk melengkungkan sudut Card
                                  side: BorderSide(color: Colors.black, width: 1.0), // Border di sekeliling Card
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(

                                    children: [
                                      Row(

                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  color: SiakColors.SiakWhite,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Pertemuan  ${rincian_absensi_mahasiswa?.pertemuan}  ",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: SiakColors.SiakPrimary,
                                                        ),
                                                      ),





                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 3,color: SiakColors.gray500,
                                                ),

                                                Container(
                                                  color: SiakColors.SiakWhite,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Topik :\n${rincian_absensi_mahasiswa?.topik}   ",
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            color: SiakColors.SiakBlack,
                                                          ),
                                                        ),
                                                      ),





                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Container(
                                                  color: SiakColors.SiakWhite,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Sub Topik : \n${rincian_absensi_mahasiswa?.subtopik}   ",
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w300,
                                                            fontStyle: FontStyle.normal,
                                                            color: SiakColors.SiakPrimary,
                                                          ),
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
                                      SizedBox(height: 20,),


                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: ListTile(
                                                        dense:true,
                                                        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                                        title: Text('H',
                                                            style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FontStyle.normal,
                                                          color: SiakColors.SiakGreenDark,)),
                                                        leading: Radio<String?>(
                                                          activeColor: SiakColors.SiakGreenDark,
                                                          value: 'H',
                                                          groupValue: selectedAbsenType,
                                                          onChanged: (String? value) {
                                                            setState(() {
                                                              selectedAbsenType = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListTile(
                                                        contentPadding: const EdgeInsets.all(0),
                                                        title:  Text('I',  style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,
                                                          fontStyle: FontStyle.normal,
                                                          color: Colors.orange,)),
                                                        leading: Radio<String?>(
                                                          activeColor: Colors.orange,
                                                          value: 'I',
                                                          groupValue: selectedAbsenType,
                                                          onChanged: (String? value) {
                                                            setState(() {
                                                              selectedAbsenType = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListTile(
                                                        contentPadding: const EdgeInsets.all(0),
                                                        title:  Text('S', style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,
                                                          fontStyle: FontStyle.normal,
                                                          color: Colors.blue,)),
                                                        leading: Radio<String?>(
                                                          value: 'S',
                                                          activeColor: Colors.blue,
                                                          groupValue: selectedAbsenType,
                                                          onChanged: (String? value) {
                                                            setState(() {
                                                              selectedAbsenType = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                          Row(

                                            children: [
                                              TextButton(

                                                onPressed: (rincian_absensi_mahasiswa?.absenButton == 0 || rincian_absensi_mahasiswa?.absenButton == "0")
                                                    ? () async {

                                                  await _databaseHelper.postIsiAbsen(selectedAbsenType!, token, widget.idJadwal.toString());
                                                  print(selectedAbsenType);

                                                }
                                                    : null,
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                        (Set<MaterialState> states) {
                                                      return Colors.transparent;
                                                    },
                                                  ),
                                                  side: MaterialStateProperty.resolveWith<BorderSide>(
                                                        (Set<MaterialState> states) {
                                                      return BorderSide(
                                                        width: 2,
                                                        color: Colors.blue,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: const [
                                                    Text("Isi Absensi"),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.edit_note_outlined,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
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

                        SizedBox(height: 100,)

                        




                      ],
                    ),
                  ),

                ],
              ),
            );
          } else if (snapshot.hasError) {

            return Text('Error: ${snapshot.error}');
          } else {

            return Text('Terjadi kesalahan.');
          }
        },
      ),

    );
  }

}
