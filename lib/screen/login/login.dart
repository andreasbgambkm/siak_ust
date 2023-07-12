import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/screen/home_screen/home_screen.dart';


class SiakLogin extends StatefulWidget {
  static final routeName = "/LoginPage";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<SiakLogin> {
  var siakUserController = TextEditingController();
  var siakPasswordController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  String msgStatus = '';


  bool visible = false;
  final String apiLogin = '$BASE_URL$LOGIN';

  bool isApiCallProcess = false;
  bool hidePassword = true;
  var status;
  String? id;
  String? password;
  String? access_token;

  @override
  void initState() {
    read();
    super.initState();
  }


  Future<void> read() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final value = prefs.getString(key);
      if (value != '' && value != null && value.isNotEmpty) {
        // Token tidak kosong, lakukan navigasi ke halaman HomeScreen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );

      } else {
        print('Token Pada Halaman Login is null');
      }
    } catch (e) {
      print('Error reading token: $e');
    }
  }


  _onPressed() {
    setState(() {
      if (siakUserController.text.trim().toLowerCase().isNotEmpty && siakPasswordController.text.trim().isNotEmpty) {
        databaseHelper.loginData(context, siakUserController.text.trim().toLowerCase(),
            siakPasswordController.text.trim()).whenComplete(() {
          if (databaseHelper.status != null && databaseHelper.status) {
            _showDialog();
            msgStatus = 'Check username or password';
          } else {
            Navigator.pushReplacementNamed(context, '/home_screen');
          }
        });
      } else {
        //Menampilkan keterangan jika username atau password kosong
        if (siakUserController.text.trim().toLowerCase().isEmpty) {
          siakUserController.clear();
          siakUserController.value = TextEditingValue(
            text: '',
            selection: TextSelection.collapsed(offset: -1),
          );
          siakUserController;
          _showErrorSnackBar('Username tidak boleh kosong');
        } else if (siakPasswordController.text.trim().isEmpty) {
          siakPasswordController.clear();
          siakPasswordController.value = TextEditingValue(
            text: '',
            selection: TextSelection.collapsed(offset: -1),
          );
          siakPasswordController;
          _showErrorSnackBar('Password tidak boleh kosong');
        }
      }
    });
  }


  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }


  _showAlertDialog(BuildContext context, String err) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SiakColors.SiakWhite,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.INFO_REVERSED,
                              borderSide: const BorderSide(
                                color: SiakColors.SiakPrimary,
                                width: 2,
                              ),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1,
                              buttonsBorderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: true,
                              headerAnimationLoop: true,
                              animType: AnimType.RIGHSLIDE,
                              title: 'Tentang Portal Akademik',
                              desc: siakDesc,

                                 showCloseIcon: false,
                            ).show();
                          },
                        ),

                        // Icon(Icons.access_alarm),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // height: double.infinity,
                          alignment: Alignment.center,
                          child: Image.asset(
                            logoUnika,
                            fit: BoxFit.contain,
                            width: 140,
                            height: 140,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                             siakTitle,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: SiakColors.SiakBlack,
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 18,
                                    fontWeight: FontWeight.w600,
                                  )),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: siakUserController,
                        obscureText: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey, width: 2),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0x80EFEFEF), width: 2),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Color(0x75000000)),
                          hintText: textFieldUsername,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: siakPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black12, width: 2),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0x80EFEFEF), width: 2),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Color(0x75000000)),
                          hintText: textFieldPassword,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20),
                        child: Container(
                          child: MaterialButton(
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            color: Color(0xFFFFE76A),
                            height: 50,
                            minWidth: double.infinity,
                            // color: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),

                            onPressed: _onPressed,

                            child: Text(loginTitle,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: SiakColors.SiakPrimary,
                                    letterSpacing: 2)),
                          ),
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: IconButton(

                              icon: const Icon(
                                FlutterIcons.facebook_f_faw5d,
                                color: SiakColors.SiakBlack,
                              ),
                              onPressed: () async {
                                final prefs = await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';
                                print(token);
                                await _clear(token);
                                print('sudah terhapus');
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.instagram_faw5d,
                                color: SiakColors.SiakBlack,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.twitter_faw5d,
                                color: SiakColors.SiakBlack,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(32)),
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.youtube_ant,
                                color: SiakColors.SiakBlack,
                              ),
                              onPressed: () {


                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 3.364,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/BottomLoginScreen.png'),
                                fit: BoxFit.fitWidth))),

                  ],
                ),
              ),

            ],
          ),
        ),


      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed'),
            content: Text('Check your email or password'),
            actions: <Widget>[
              TextButton(

                child: Text('Close',),

                onPressed: () {
                  Navigator.of(context).pop();
                },

              ),
            ],
          );
        }
    );
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }


  _clear(String token) async {
    await removeToken();
  }
}