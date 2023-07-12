import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_constant.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/core/utils/image_constant.dart';
import 'package:siak/core/utils/size_utils.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/screen/berita/berita_terkini.dart';
import 'package:siak/theme/app_decoration.dart';
import 'package:siak/theme/app_style.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/home_screen_item_widget.dart';
import 'package:siak/widgets/home_widgets/custom_button.dart';
import 'package:siak/widgets/home_widgets/custom_icon_button.dart';
import 'package:siak/widgets/home_widgets/custom_image_view.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScreen = '/home_screen';

  HomeScreen({super.key, this.profileJurusan, this.profileNama, this.profileNpm});
  String? profileNama;
  String? profileNpm;
  String? profileJurusan;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ProfileMahasiswa? _profileData;
  String? profileJurusan;
  String? profileNama;
  String? profileNpm;
  String? profileFakultas;

  DatabaseHelper _getProfile = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _getData();

  }


  Future<ProfileMahasiswa?> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _getProfile.fetchProfileMahasiswa(token);
      print(data);

      if (data != null && data.isNotEmpty) {
        // Konversi Map<String, dynamic> menjadi JSON string
        final jsonData = jsonEncode(data);

        // Simpan data ke dalam SharedPreferences
        await prefs.setString('profile', jsonData);
        print('ini data yang disimpan ke shared preferences');
        print(jsonData);
        print(prefs);

        return ProfileMahasiswa.fromJson(data);
      } else {
        // Data kosong, kembalikan nilai null
        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
        return null;
      }
    } else {
      // Token tidak ada atau kosong, kembalikan nilai null
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: FutureBuilder<ProfileMahasiswa?>(
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SiakDrawer(
                    profileNama: _profileData?.nama,
                    profileNpm: _profileData?.npm.toString(),
                    context: context,
                  );
                } else {
                  return CircularProgressIndicator(
                    color: SiakColors.SiakPrimaryLightColor,
                  );
                }
              },
            ),

            backgroundColor: ColorConstant.whiteA700,
            appBar: SiakAppbar(
              onImageTap: () {

              },
              imagePath: ImageConstant.imgUnika12,
            ),
                    body: FutureBuilder<ProfileMahasiswa?>(
                      future: _getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator()); // Tampilkan indikator loading saat data sedang dimuat
                        }
                        if (snapshot.hasError) {
                          return Text('Terjadi kesalahan: ${snapshot.error}'); // Tampilkan pesan kesalahan jika terjadi error
                        }
                        if (snapshot.hasData) {
                          _profileData = snapshot.data!;
                          //parameter untuk dikirim ke widget dan page lain
                          profileNama = _profileData?.nama;
                          profileNpm = _profileData?.npm.toString();

                          return SizedBox(
                              width: size.width,
                              child: SingleChildScrollView(
                                  padding: getPadding(top: 25),
                                  child: Padding(
                                      padding: getPadding(left: 26, bottom: 5),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                                padding: getPadding(left: 3),
                                                child: Text(
                                                    "Halo, ${_profileData?.nama ?? ''}!",
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsSemiBold20Black900)
                                            ),
                                            Padding(
                                                padding: getPadding(left: 3),
                                                child: Text(
                                                    "Selamat datang kembali civitas!",
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsMedium12)),
                                            Container(
                                                margin: getMargin(
                                                    top: 17,),
                                                padding: getPadding(
                                                    left: 20,
                                                    top: 33,
                                                    right: 20,
                                                    bottom: 33),
                                                decoration: AppDecoration
                                                    .outlineBluegray700
                                                    .copyWith(
                                                    borderRadius:
                                                    BorderRadiusStyle
                                                        .roundedBorder5),
                                                child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                          child:Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(bottom: 20),
                                                                child: const CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundImage: AssetImage('assets/images/siak_user.png'),
                                                             ),
                                                              ),
                                                            ],
                                                          )

                                                      ),
                                                      Padding(
                                                          padding: getPadding(
                                                              left: 18,
                                                              top: 3,
                                                              right: 14,
                                                              bottom: 2),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .centerRight,
                                                                    child: FittedBox(
                                                                      fit: BoxFit.fitWidth,
                                                                      child: Text(
                                                                         "${capitalize(_profileData?.nama ?? '')}",
                                                                          overflow: TextOverflow.ellipsis,
                                                                          textAlign:
                                                                          TextAlign.left,
                                                                          style: AppStyle.txtPoppinsSemiBold13),
                                                                    )),
                                                                Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    child: Text(
                                                                        "Teknik Informatika - 19",
                                                                        overflow: TextOverflow
                                                                            .ellipsis,
                                                                        textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                        style: AppStyle
                                                                            .txtPoppinsMedium16)),
                                                                Padding(
                                                                    padding: getPadding(
                                                                        left: 8,
                                                                        top: 1),
                                                                    child: Text(
                                                                        "${_profileData?.npm ?? ''}",
                                                                        overflow: TextOverflow
                                                                            .ellipsis,
                                                                        textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                        style: AppStyle
                                                                            .txtPoppinsMedium16)),
                                                                CustomButton(
                                                                    height:
                                                                    getVerticalSize(
                                                                        30),
                                                                    width: getHorizontalSize(
                                                                        139),
                                                                    text:
                                                                    "Lihat selengkapnya",
                                                                    margin:
                                                                    getMargin(
                                                                        top: 10),
                                                                    onTap: () {

                                                                        Navigator.of(context).pushReplacementNamed("/ProfilePage");

                                                                    })
                                                              ]))
                                                    ])),
                                            Padding(
                                                padding: getPadding(
                                                    left: 8, top: 26),
                                                child: Text("Menu Utama",
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign.left,
                                                    style: AppStyle
                                                        .txtPoppinsSemiBold15)),
                                            Padding(
                                                padding:
                                                getPadding(left: 25,
                                                    top: 12,
                                                    right: 51),
                                                child: Row(children: [
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      onTap: () {
                                                        Navigator.of(context).pushReplacementNamed("/RegistrasiPage");;
                                                      },
                                                      child: CustomImageView(
                                                          svgPath: ImageConstant.imgEdit)),
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      margin: getMargin(
                                                          left: 39),
                                                      child: CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgFile)),
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      margin: getMargin(
                                                          left: 39),
                                                      onTap: () {
                                                        onTapBtnArrowdown(
                                                            context);
                                                      },
                                                      child: CustomImageView(
                                                          svgPath:
                                                          ImageConstant
                                                              .imgArrowdown)),
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      margin: getMargin(
                                                          left: 36),
                                                      onTap: () {
                                                        onTapBtnBarchartthree(
                                                            context);
                                                      },
                                                      child: CustomImageView(
                                                          svgPath: ImageConstant.imgBarchart3))
                                                ])),


                                            Padding(
                                                padding:
                                                getPadding(left: 22,
                                                    top: 1,
                                                    right: 63),
                                                child: Row(
                                                    children: [
                                                  Padding(padding: getPadding(top: 1),
                                                      child: Text("Registrasi",
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.left,
                                                          style: AppStyle.txtPoppinsMedium13)),
                                                  Spacer(flex: 32),
                                                  Padding(
                                                      padding: getPadding(
                                                          bottom: 1),
                                                      child: Text("KRS",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                          AppStyle
                                                              .txtPoppinsMedium13)),
                                                  Spacer(flex: 34),
                                                  Padding(
                                                      padding: getPadding(
                                                          bottom: 1),
                                                      child: Text("Kuitansi",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                          AppStyle
                                                              .txtPoppinsMedium13)),
                                                  Spacer(flex: 33),
                                                  Padding(
                                                      padding: getPadding(
                                                          bottom: 1),
                                                      child: Text("Nilai",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: AppStyle
                                                              .txtPoppinsMedium13))
                                                ])),


                                            Padding(
                                                padding:
                                                getPadding(left: 25,
                                                    top: 18,
                                                    right: 51),
                                                child: Row(children: [
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      onTap: () {
                                                        onTapBtnBrowser(
                                                            context);
                                                      },
                                                      child: CustomImageView(svgPath: ImageConstant.imgBrowser)),
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      margin: getMargin(
                                                          left: 40),
                                                      onTap: () {onTapBtnFileone(context);
                                                      },
                                                      child: CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgFileWhiteA700)),
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 52,
                                                      margin: getMargin(
                                                          left: 40),
                                                      onTap: () {
                                                        onTapBtnListclipboard(context);
                                                      },
                                                      child: CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgListclipboard)),
                                                  CustomIconButton(
                                                      height: 53,
                                                      width: 53,
                                                      margin: getMargin(
                                                          left: 35),
                                                      onTap: () {
                                                        onTapBtnMail(context);
                                                      },
                                                      child: CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgMail))
                                                ])),
                                            Padding(
                                                padding:
                                                getPadding(left: 40,
                                                    top: 2,
                                                    right: 59),
                                                child: Row(children: [
                                                  Padding(
                                                      padding: getPadding(
                                                          bottom: 1),
                                                      child: Text("KHS",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                          AppStyle
                                                              .txtPoppinsMedium13)),
                                                  Spacer(),
                                                  Padding(
                                                      padding: getPadding(
                                                          top: 1),
                                                      child: Text("Transkrip",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                          AppStyle
                                                              .txtPoppinsMedium13)),
                                                  Padding(
                                                      padding:
                                                      getPadding(
                                                          left: 39, bottom: 1),
                                                      child: Text("Absensi",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                          AppStyle
                                                              .txtPoppinsMedium13)),
                                                  Padding(
                                                      padding:
                                                      getPadding(
                                                          left: 49, bottom: 1),
                                                      child: Text("Surat ",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: AppStyle
                                                              .txtPoppinsMedium13))
                                                ])),
                                            Padding(
                                                padding:
                                                getPadding(left: 8,
                                                    top: 33,
                                                    right: 33),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text("Berita Terkini",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign
                                                              .left,
                                                          style:
                                                          AppStyle
                                                              .txtPoppinsSemiBold15),
                                                      Padding(
                                                        padding: getPadding(bottom: 2),
                                                        child: InkWell(
                                                          onTap: () {
                                                            print('.........');
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => SiakNews()),

                                                            );
                                                          },
                                                          child: Text(
                                                            "Lihat Semua",
                                                            overflow: TextOverflow.ellipsis,
                                                            textAlign: TextAlign.left,
                                                            style: AppStyle.txtPoppinsMedium13Gray600,
                                                          ),
                                                        ),
                                                      )

                                                    ])),
                                            Align(
                                                alignment: Alignment
                                                    .centerRight,
                                                child: Container(
                                                    height: getVerticalSize(
                                                        223),
                                                    child: ListView.separated(
                                                        padding: getPadding(
                                                            left: 3, top: 8),
                                                        scrollDirection: Axis
                                                            .horizontal,
                                                        separatorBuilder: (
                                                            context, index) {
                                                          return SizedBox(
                                                              height: getVerticalSize(
                                                                  20));
                                                        },
                                                        itemCount: 3,
                                                        itemBuilder: (context,
                                                            index) {
                                                          return HomeScreenItemWidget();
                                                        }))),
                                            Padding(
                                                padding: getPadding(
                                                    left: 61, top: 38),
                                                child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      CustomImageView(
                                                          imagePath: ImageConstant
                                                              .imgBnilogowithtagline,
                                                          height: getVerticalSize(
                                                              32),
                                                          width: getHorizontalSize(
                                                              60),
                                                          margin: getMargin(
                                                              top: 1)),
                                                      CustomImageView(
                                                          imagePath:
                                                          ImageConstant
                                                              .imgLogobanpt1,
                                                          height: getVerticalSize(
                                                              30),
                                                          width: getHorizontalSize(
                                                              35),
                                                          margin: getMargin(
                                                              left: 16,
                                                              top: 1,
                                                              bottom: 2)),
                                                      CustomImageView(
                                                          imagePath: ImageConstant
                                                              .imgLogoristekdiktipng,
                                                          height: getVerticalSize(
                                                              31),
                                                          width: getHorizontalSize(
                                                              28),
                                                          margin:
                                                          getMargin(left: 16,
                                                              bottom: 2)),
                                                      CustomImageView(
                                                          imagePath:
                                                          ImageConstant
                                                              .imgLogoaptik1,
                                                          height: getVerticalSize(
                                                              30),
                                                          width: getHorizontalSize(
                                                              25),
                                                          margin: getMargin(
                                                              left: 16,
                                                              top: 1,
                                                              bottom: 2)),
                                                      CustomImageView(
                                                          imagePath:
                                                          ImageConstant
                                                              .imgLogoadlaptik1,
                                                          height: getVerticalSize(
                                                              20),
                                                          width: getHorizontalSize(
                                                              48),
                                                          margin: getMargin(
                                                              left: 10,
                                                              top: 6,
                                                              bottom: 7))
                                                    ]
                                                )
                                            )
                                          ]

                                      )
                                  )
                              )
                          );

                        }
                        return CircularProgressIndicator(backgroundColor: SiakColors.SiakPrimary,);
                      }
                      ),

            bottomNavigationBar: Container(
                height: getVerticalSize(20),
                width: getHorizontalSize(320),
                margin: getMargin(left: 52, right: 55, bottom: 23),
                child: Stack(alignment: Alignment.centerLeft, children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          "2022 - Lembaga Pusat Sistem Informasi (LPSI)",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold13)),
                  CustomImageView(
                      imagePath: ImageConstant.imgCopyright,
                      height: getVerticalSize(10),
                      width: getHorizontalSize(18),
                      alignment: Alignment.centerLeft)
                ]))
        )


         );
  }

  onTapLihat(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnEdit(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnArrowdown(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnBarchartthree(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnBrowser(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnFileone(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnListclipboard(BuildContext context) {
    // TODO: implement Actions
  }

  onTapBtnMail(BuildContext context) {
    // TODO: implement Actions
  }



  String capitalize(String text) {
    if (text.isEmpty) return '';
    return text.toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

}
