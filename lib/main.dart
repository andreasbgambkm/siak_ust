
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/screen/absensi/isi_absensi/isi_absensi.dart';
import 'package:siak/screen/berita/berita_terkini.dart';
import 'package:siak/screen/krs/krs_diambil_page/krs_diambil.dart';
import 'package:siak/screen/nilai/angket/isi_angket/isi_angket.dart';
import 'package:siak/screen/nilai/angket/review_angket/rekap_angket.dart';
import 'package:siak/screen/nilai/complain/complain.dart';
import 'package:siak/screen/nilai/nilai_uas/nilai_uas.dart';
import 'package:siak/screen/nilai/nilai_uts/nilai_uts.dart';
import 'package:siak/screen/suratpermohonan/seminar_isi/seminar_isi_form.dart';
import 'package:siak/screen/suratpermohonan/sidang/sidang_form.dart';
import 'package:siak/screen/suratpermohonan/sk_pembimbing/sk_pembimbing_form.dart';
import 'package:siak/screen/suratpermohonan/surat_cuti/surat_cuti_form.dart';
import 'package:siak/screen/suratpermohonan/surat_riset/surat_riset_form.dart';
import 'package:siak/screen/suratpermohonan/surat_sempro/surat_sempro_form.dart';
import 'package:siak/screen/suratpermohonan/tes_program/tes_program_form.dart';
import 'screen/absensi/absensi.dart';
import 'screen/home_screen/home_screen.dart';
import 'screen/khs/khs.dart';
import 'screen/krs/isi_krs_page/isi_krs.dart';
import 'screen/krs/krs.dart';
import 'screen/kuitansi/kuitansi.dart';
import 'screen/login/login.dart';
import 'screen/nilai/nilai.dart';
import 'screen/profile/profile.dart';
import 'screen/registrasi/registrasi.dart';
import 'screen/suratpermohonan/sp.dart';
import 'screen/suratpermohonan/surat_aktif/surat_aktif_form.dart';
import 'screen/transkripsementara/transkrip.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  SharedPreferences? sharedPreferences;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getToken();
  }

  void _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token') ?? '';
    print('Token: $token');
  }
  // cek status login
  Future<void> checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences?.getString('token') != null &&
        sharedPreferences?.getString('token') != '') {
      isLoggedIn = true;
      sharedPreferences?.setBool('isLoggedIn', true);
    }

    setState(() {
      isLoggedIn = sharedPreferences?.getBool('isLoggedIn') ?? false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siak Ust',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedIn ? HomeScreen() : SiakLogin(),
      routes: {
        "/LoginPage": (BuildContext context) => SiakLogin(),
        "/home_screen": (BuildContext context) => HomeScreen(),
        "/ProfilePage": (BuildContext context) => SiakProfile(),
        "/RegistrasiPage": (BuildContext context) => SiakRegistrasi(),
        "/KuitansiPage": (BuildContext context) => SiakKuitansi(),
        "/KRSPage": (BuildContext context) => SiakKRS(),
        "/KRSDiambilPage": (BuildContext context) => SiakKRSDiambil(),
        "/IsiKRSPage": (BuildContext context) => SiakIsiKRS(),
        "/AbsensiPage": (BuildContext context) => SiakAbsensi(),
        "/NilaiPage": (BuildContext context) => SiakNilai(),
        "/KHSPage": (BuildContext context) => SiakKHS(),
        "/TranskripPage": (BuildContext context) => SiakTranskrip(),
        "/SPPage": (BuildContext context) => SiakSP(),
        '/A-01': (context) => SuratAktif(),
        '/A-02': (context) => SuratSempro(),
        '/A-03': (context) => SuratRiset(),
        '/A-04': (context) => SuratCuti(),
        '/A-07': (context) => TesProgram(),
        '/A-08': (context) => SeminarIsi(),
        '/A-09': (context) => Sidang(),
        '/A-13': (context) => SkPembimbing(),
        "/SiakNews": (BuildContext context) => SiakNews(),
        "/SiakNilaiUts": (BuildContext context) => SiakNilaiUts(),
        "/SiakNilaiUas": (BuildContext context) => SiakNilaiUas(),
        "/SiakIsiAngket": (BuildContext context) => SiakIsiAngket(),
        "/SiakReviewAngket": (BuildContext context) => SiakRekapAngket(),
        "/SiakComplain" : (BuildContext context) => SiakComplain(),
        // "/SiakIsiAbsensi" : (BuildContext context) => SiakIsiAbsensi(),
      },
    );
  }
}

