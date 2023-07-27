import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/core/utils/size_utils.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';

class SiakAppbar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onImageTap;
  final String? imagePath;
  final Widget? leading;

  SiakAppbar({this.onImageTap, this.imagePath, this.leading});

  @override
  State<SiakAppbar> createState() => _SiakAppbarState();


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

class _SiakAppbarState extends State<SiakAppbar> {


  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;


  @override
  Size get preferredSize => const Size.fromHeight(56);

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _databaseHelper.getProfileDataFromPreferences();

    setState(() {

      _profileMahasiswa = profile;
    });
  }

  Future<ProfileMahasiswa?> _getDataMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);


    if (token != null && token.isNotEmpty) {
      // Periksa apakah data profil sudah ada dalam preferences
      final storedProfile = prefs.getString('profile');
      if (storedProfile != null && storedProfile.isNotEmpty) {
        // Jika data profil sudah ada, langsung kembalikan objek ProfileMahasiswa
        return ProfileMahasiswa.fromJson(jsonDecode(storedProfile));
      } else {
        final data = await _databaseHelper.fetchProfileMahasiswa(token);

        print(data);

        if (data != null && data.isNotEmpty) {
          // Konversi Map<String, dynamic> menjadi JSON string
          final jsonData = jsonEncode(data);

          // Simpan data ke dalam SharedPreferences
          await prefs.setString('profile', jsonData);

          return ProfileMahasiswa.fromJson(data);
        } else {
          // Data kosong, kembalikan nilai null
          Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
          return null;
        }
      }
    } else {
      // Token tidak ada atau kosong, kembalikan nilai null
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return null;
    }
  }

  Future _getAllDataProfile() async{
    await _getDataMahasiswa();
    await _loadProfileDataFromLocal();
  }

  @override
  void initState() {
    super.initState();
    _getAllDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    final String finalImagePath = widget.imagePath ?? 'assets/images/logoust.png';

    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      backgroundColor: SiakColors.SiakPrimary,
      leading: widget.leading,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: widget.onImageTap,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(finalImagePath),
                ),
              ),
            ),
          ),
        ),
      ],
      title: Text(
        "FAKULTAS ${(_profileMahasiswa?.fakultas ?? '...........')}",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width / 20,
        ),
      ),
      centerTitle: true,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    required this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  });

  double height;

  Style? styleType;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
    size.width,
    height,
  );
  _getStyle() {
    switch (styleType) {
      case Style.bgFillRed900:
        return Container(
          height: getVerticalSize(
            66,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: SiakColors.red900,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                getHorizontalSize(
                  10,
                ),
              ),
              bottomRight: Radius.circular(
                getHorizontalSize(
                  10,
                ),
              ),
            ),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFillRed900,
}
