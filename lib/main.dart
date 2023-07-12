
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/screen/berita/berita_terkini.dart';
import 'screen/absensi/absensi.dart';
import 'screen/home_screen/home_screen.dart';
import 'screen/khs/khs.dart';
import 'screen/krs/krs.dart';
import 'screen/kuitansi/kuitansi.dart';
import 'screen/login/login.dart';
import 'screen/nilai/nilai.dart';
import 'screen/profile/profile.dart';
import 'screen/registrasi/registrasi.dart';
import 'screen/suratpermohonan/sp.dart';
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
        "/AbsensiPage": (BuildContext context) => SiakAbsensi(),
        "/NilaiPage": (BuildContext context) => SiakNilai(),
        "/KHSPage": (BuildContext context) => SiakKHS(),
        "/TranskripPage": (BuildContext context) => SiakTranskrip(),
        "/SPPage": (BuildContext context) => SiakSP(),
        "/SiakNews": (BuildContext context) => SiakNews(),
      },
    );
  }
}

