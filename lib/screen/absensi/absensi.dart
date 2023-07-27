import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/siak_models/absensi_model.dart';
import 'package:siak/screen/absensi/isi_absensi/isi_absensi.dart';
import 'package:siak/screen/absensi/rincian_absensi/rincian_absensi.dart';
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


class SiakAbsensi extends StatefulWidget {


  const SiakAbsensi({Key? key}) : super(key: key);

  @override
  State<SiakAbsensi> createState() => _SiakAbsensiState();
}

class _SiakAbsensiState extends State<SiakAbsensi> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  List<RegistrasiElement> registrasiList = [];
  String? _registrasiLastest;
  bool isAllActive = false;
  Registrasi? _reg;
  List<AbsensiMataKuliah?> _absensiMataKuliahList = [];


  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadRegistrasiDataFromLocal();
    _loadAbsensiMataKuliahDataFromServer();


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
  Future<List<MataKuliah?>> _loadAbsensiMataKuliahDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchDataMataKuliahAbsensi(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final absensiModel = AbsensiMataKuliah.fromJson(data);
        return absensiModel.matakuliah;
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
      appBar: SiakAppbar(),
      bottomSheet: SiakBottomSheet(),
      drawer: SiakDrawer(context: context),
      body: FutureBuilder<List<MataKuliah?>>(
        future: _loadAbsensiMataKuliahDataFromServer(),
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
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        TitlePage(
                          title: 'Absensi Mahasiswa',
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
                        const Padding(
                          padding: EdgeInsets.only(left:15, top: 10 ),
                          child: Text(
                            'Daftar Absensi Mata Kuliah',
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
                            itemCount: absensi.length,
                            itemBuilder: (context, index) {

                              print(absensi);
                              final absensi_mahasiswa = absensi[index];

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
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: Colors.yellow.shade200,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "${absensi_mahasiswa?.nmMatkul}   ",
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
                                      SizedBox(height: 10,),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: SiakColors.SiakPrimary,
                                          borderRadius: BorderRadius.circular(10),),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            _buildBackgroundLabel("  Alpha :", SiakColors.SiakPrimary,"${absensi_mahasiswa?.absensi.alpha}", SiakColors.SiakPrimaryLightColor   ),
                                            _buildBackgroundLabel("Ijin :", SiakColors.SiakPrimary,"${absensi_mahasiswa?.absensi.ijin}", SiakColors.SiakPrimaryLightColor ),
                                            _buildBackgroundLabel("Sakit :", SiakColors.SiakPrimary,"${absensi_mahasiswa?.absensi.sakit}", SiakColors.SiakPrimaryLightColor ),
                                            _buildBackgroundLabel("Hadir :" , SiakColors.SiakPrimary,"${absensi_mahasiswa?.absensi.hadir}", SiakColors.SiakPrimaryLightColor ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),

                                      Row(


                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: TextButton(
                                                          onPressed: () {

                                                            int? hadir = absensi_mahasiswa?.absensi.hadir.toInt();
                                                            int? alpha = absensi_mahasiswa?.absensi.alpha.toInt();
                                                            int? ijin = absensi_mahasiswa?.absensi.ijin.toInt();
                                                            int? sakit = absensi_mahasiswa?.absensi.sakit.toInt();

                                                            showAlertDialog(context, hadir!, alpha!, ijin!, sakit!);


                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Icon(
                                                                Icons.bar_chart,
                                                                size: 16,
                                                              ),
                                                              SizedBox(width: 5),
                                                              Text("Persentase : ${absensi_mahasiswa?.absensi.presentase} %"),


                                                            ],
                                                          ),
                                                        ),
                                                      ),


                                                      Container(
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            await Navigator.pushReplacement(
                                                              context, MaterialPageRoute(builder: (context) =>
                                                                SiakIsiAbsensi(
                                                                  idJadwal: absensi_mahasiswa?.idJadwal.toString(),
                                                                  namaMatkul: absensi_mahasiswa?.nmMatkul.toString(),) ),
                                                            );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                                  (Set<MaterialState> states) {
                                                                return Colors.transparent;
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
                                                      ),

                                                      Container(
                                                        child: TextButton(
                                                          onPressed: () async {

                                                            await Navigator.pushReplacement(
                                                              context, MaterialPageRoute(builder: (context) =>
                                                                SiakRincianAbsensi(
                                                                  idJadwal: absensi_mahasiswa?.idJadwal.toString(),
                                                                  namaMatkul: absensi_mahasiswa?.nmMatkul.toString(),
                                                                  kdMatkul: absensi_mahasiswa?.kdMatkul.toString(),) ),
                                                            );

                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                                  (Set<MaterialState> states) {
                                                                return Colors.transparent; // Ganti dengan warna biru yang diinginkan
                                                              },
                                                            ),
                                                          ),

                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: const [
                                                              Text("Rincian"),

                                                              SizedBox(width: 5),
                                                              Icon(
                                                                Icons.check_box_outlined,
                                                                size: 16,
                                                              ),

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
  Widget _buildBackgroundLabel(
      String textTitle,
      Color backgroundTitle,
      String textCountAbsen,
      Color backgroundCounter,
      ) {
    return Row(
      children: [
        Container(

          decoration: BoxDecoration(
            color: backgroundTitle,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            textTitle,
            style: GoogleFonts.poppins(color: SiakColors.SiakWhite),
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: backgroundCounter,
            borderRadius: BorderRadius.circular(10),

          ),
          child: Text(
            textCountAbsen,
            style: GoogleFonts.poppins(color: SiakColors.SiakPrimary),
          ),
        ),
      ],
    );
  }


}
