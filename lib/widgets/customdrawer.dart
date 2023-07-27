import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/screen/absensi/absensi.dart';
import 'package:siak/screen/home_screen/home_screen.dart';
import 'package:siak/screen/khs/khs.dart';
import 'package:siak/screen/krs/krs.dart';
import 'package:siak/screen/kuitansi/kuitansi.dart';
import 'package:siak/screen/login/login.dart';
import 'package:siak/screen/nilai/nilai.dart';
import 'package:siak/screen/profile/profile.dart';
import 'package:siak/screen/registrasi/registrasi.dart';
import 'package:siak/screen/suratpermohonan/sp.dart';
import 'package:siak/screen/transkripsementara/transkrip.dart';
import 'dart:io';

import '../core/utils/color_pallete.dart';

class SiakDrawer extends StatefulWidget {
  final String? profileNama;
  final String? profileNpm;
  final BuildContext context;

  SiakDrawer({this.profileNama, this.profileNpm,required this.context});

  @override
  State<SiakDrawer> createState() => _SiakDrawerState();
}

class _SiakDrawerState extends State<SiakDrawer> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;

  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
  }

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _databaseHelper.getProfileDataFromPreferences();
    setState(() {
      _profileMahasiswa = profile;
    });
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            width: 175,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: SiakColors.SiakPrimary, width: 2),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child:
              Image.network(
                _profileMahasiswa?.foto ?? '',
                width: 175,
                height: 200,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  // Jika foto dari URL gagal dimuat, kita menggunakan gambar dari path lokal
                  return Image.asset(
                    'assets/images/siak_user.png',
                    width: 175,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),





        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            child: Center(
              child: Text(
                _profileMahasiswa?.nama ?? '',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: SiakColors.SiakBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Container(
            child: Center(
              child: Text(
                _profileMahasiswa?.npm.toString() ?? '',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: SiakColors.SiakBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Implementasi metode _buildDrawerItem dan _buildLogoutItem
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          _buildProfileSection(),
          ListTile(
            title: Text(
              'Dashboard',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.dashboard_rounded,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen(),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              'Profil',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.person,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakProfile(),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              'Registrasi',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.note_add_rounded,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakRegistrasi(profileNama: widget.profileNama,profileNpm: widget.profileNpm,),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              'Cetak Kuitansi',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.print,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakKuitansi(),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              'Kartu Rencana Studi',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.note_add_outlined,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakKRS(),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              'Absensi',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.task,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakAbsensi(),
                ),
              );
            },
          ),

          ListTile(
            title: Text(
              'Nilai',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.bar_chart,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakNilai(),),

              );
            },
          ),

          ListTile(
            title: Text(
              'Kartu Hasil Studi',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.credit_card,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakKHS(),),

              );
            },
          ),

          ListTile(
            title: Text(
              'Transkrip Sementara',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.table_chart,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakTranskrip()),

              );
            },
          ),

          ListTile(
            title: Text(
              'Surat Permohonan',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: SiakColors.SiakPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leading: Icon(
              Icons.library_books_outlined,
              color: SiakColors.SiakPrimary,
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SiakSP(),
                ),
              );
            },
          ),


          _buildLogoutItem(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, String routeName) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: SiakColors.SiakPrimary,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: Icon(
        icon,
        color: SiakColors.SiakPrimary,
      ),
      onTap: () {
        Navigator.of(widget.context).pushReplacementNamed(routeName);
      },
    );
  }

  Widget _buildLogoutItem() {
    return ListTile(
      title: Text(
        "Logout",
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: SiakColors.SiakPrimary,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: const Icon(
        Icons.exit_to_app,
        color: SiakColors.SiakPrimary,
      ),
      onTap: () {
        AwesomeDialog(
          context: widget.context,
          dialogType: DialogType.WARNING,
          borderSide: const BorderSide(
            color: SiakColors.SiakPrimary,
            width: 2,
          ),
          width: MediaQuery.of(widget.context).size.width / 1,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: true,
          btnOkOnPress: () async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('token') ?? '';
            print(token);
            await _clear(token);
            print('sudah terhapus');

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
          },
          btnCancelOnPress: () {},
          headerAnimationLoop: true,
          animType: AnimType.RIGHSLIDE,
          title: 'Anda Yakin Ingin Logout ?',
          showCloseIcon: false,
        ).show();
      },
    );
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  _clear(String token) async {
    await removeToken();
    await clearSharedPreferences();
  }

}
