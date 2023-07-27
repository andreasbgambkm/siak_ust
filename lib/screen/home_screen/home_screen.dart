import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_constant.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/core/utils/image_constant.dart';
import 'package:siak/core/utils/size_utils.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/fakultas_model.dart';
import 'package:siak/model/siak_models/isi_krs_model.dart';
import 'package:siak/model/siak_models/jurusan_model.dart';
import 'package:siak/model/siak_models/khs_model.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/notifikasi_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:siak/model/siak_models/surat_permohonan.dart';
import 'package:siak/screen/berita/berita_terkini.dart';
import 'package:siak/screen/notifikasi/notifikasi.dart';
import 'package:siak/theme/app_decoration.dart';
import 'package:siak/theme/app_style.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_avatar.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/custom_progress_dialog.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/home_screen_item_widget.dart';
import 'package:siak/widgets/home_widgets/custom_button.dart';
import 'package:siak/widgets/home_widgets/custom_icon_button.dart';
import 'package:siak/widgets/home_widgets/custom_image_view.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScreen = '/home_screen';
  String? profileNama;
  String? profileNpm;
  String? profileJurusan;
  HomeScreen({super.key, this.profileJurusan, this.profileNama, this.profileNpm});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //server
  ProfileMahasiswa? _profileData;


  //local
  ProfileMahasiswa? _profileMahasiswa;
  Fakultas? _fakultas;
  Prodi? _prodi;

  Krs? _krsMahasiswa;
  String? profileJurusan;
  String? profileNama;
  String? profileNpm;
  String? profileFakultas;

  final DatabaseHelper _getProfile = DatabaseHelper();
  final  DatabaseHelper _getKrs = DatabaseHelper();
  final DatabaseHelper _getRegistrasi = DatabaseHelper();
  final DatabaseHelper _getSuratPermohonan = DatabaseHelper();
  final DatabaseHelper _getKHS = DatabaseHelper();
  final DatabaseHelper _getPengumuman = DatabaseHelper();
  final DatabaseHelper _getJadwalKrs = DatabaseHelper();

  List<Map<String, String>> items = [
    {
      'title': 'UNIKA BERSAMA BADAN KEAHLIAN DPR RI BAHAS ARAH PERUBAHAN UU TENTANG DESA',
      'description': 'Jumat, 7 Juli 2023 Universitas Katolik (Unika) Santo Thomas melakukan pembahasan tentang arah perubahan UU No.6 Tahun 2014 tentang desa. Salah satu isi UU tersebut',
      'url': 'https://www.ust.ac.id/unika-bersama-badan-keahlian-dpr-ri-bahas-arah-perubahan-uu-tentang-desa/',
    },
    {
      'title': 'MEMBANGUN SINERGITAS SDM, FKIP UNIKA SANTO THOMAS LAKUKAN DISKUSI VISI MISI',
      'description': 'Pada hari Selasa, 4 Juli 2023 Rektor Universitas Katolik (UNIKA) Santo Thomas, Prof. Dr. Maidin Gultom, SH, M.Hum, pengurus Yayasan Santo Thomas yang dihadiri oleh',
      'url': 'https://www.ust.ac.id/membangun-sinergitas-sdm-fkip-unika-santo-thomas-lakukan-diskusi-visi-misi/',
    },
    {
      'title': 'REKTOR UNIKA SANTO THOMAS LANTIK DEKAN, WAKIL DEKAN, KEPALA LABORATORIUM & ADMINISTRASI UMUM',
      'description': 'Rektor Universitas Katolik (UNIKA) Santo Thomas, Prof. Dr. Maidin Gultom, SH, M.Hum resmi melantik Dekan, Wakil Dekan, Kepala Laboratorium & Administrasi Umum Universitas Katolik Santo...',
      'url': 'https://www.ust.ac.id/rektor-unika-santo-thomas-lantik-dekan-wakil-dekan-kepala-laboratorium-administrasi-umum/',
    },

  ];



  @override
  void initState() {
    super.initState();
    getAllData();
    _loadProfileDataFromLocal();

  }


  Future getAllData() async {
   await _getDataMahasiswa();
   await _getDataKrs();
   await _getDataKHS();
   await _getDataRegistrasi();
   await _getDataSuratPermohonan();


  }





//server

  Future<ProfileMahasiswa?> _getDataMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);


    if (token != null && token.isNotEmpty) {
      final storedProfile = prefs.getString('profile');
      if (storedProfile != null && storedProfile.isNotEmpty) {
        return ProfileMahasiswa.fromJson(jsonDecode(storedProfile));
      } else {
        final data = await _getProfile.fetchProfileMahasiswa(token);

        print(data);

        if (data != null && data.isNotEmpty) {
          final jsonData = jsonEncode(data);

          await prefs.setString('profile', jsonData);

          return ProfileMahasiswa.fromJson(data);
        } else {

          Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
          return null;
        }
      }
    } else {

      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return null;
    }
  }

  Future<Krs?> _getDataKrs() async {


    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final storedKrs = prefs.getString('krs');
      if (storedKrs != null && storedKrs.isNotEmpty) {
        return Krs.fromJson(jsonDecode(storedKrs));
      } else {
        final data = await _getKrs.fetchKrsMahasiswa(token);

        print(data);

        if (data != null && data.isNotEmpty) {
          final jsonData = jsonEncode(data);

          await prefs.setString('krs', jsonData);

          return Krs.fromJson(data);
        } else {
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



  Future<Registrasi?> _getDataRegistrasi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final storedRegistrasi = prefs.getString('registrasi');
      if (storedRegistrasi!= null && storedRegistrasi.isNotEmpty) {
        return Registrasi.fromJson(jsonDecode(storedRegistrasi));
      } else {
        final data = await _getRegistrasi.fetchRegistrasiMahasiswa(token);

        print(data);

        if (data != null && data.isNotEmpty) {
          final jsonData = jsonEncode(data);

          await prefs.setString('registrasi', jsonData);

          return Registrasi.fromJson(data);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
          return null;
        }
      }
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return null;
    }
  }

  Future<KhsModel?> _getDataKHS() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);


    if (token != null && token.isNotEmpty) {
      final storedKhs = prefs.getString('khs');
      if (storedKhs != null && storedKhs.isNotEmpty) {
         return KhsModel.fromJson(jsonDecode(storedKhs));
      } else {
        final data = await _getProfile.fetchKhs(token);

        print("ini data KHS : $data");

        if (data != null && data.isNotEmpty) {
          // Konversi Map<String, dynamic> menjadi JSON string
          final jsonData = jsonEncode(data);

          // Simpan data ke dalam SharedPreferences
          await prefs.setString('khs', jsonData);

          return KhsModel.fromJson(data);
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

  Future<SuratPermohonan?> _getDataSuratPermohonan() async {


    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      // Periksa apakah data profil sudah ada dalam preferences
      final storedSP = prefs.getString('surat_permohonan');
      if (storedSP != null && storedSP.isNotEmpty) {
        // Jika data profil sudah ada, langsung kembalikan objek SuratPermohonan
        return SuratPermohonan.fromJson(jsonDecode(storedSP));
      } else {
        final data = await _getSuratPermohonan.fetchSuratPermohonan(token);

        print(data);

        if (data != null && data.isNotEmpty) {
          // Konversi Map<String, dynamic> menjadi JSON string
          final jsonData = jsonEncode(data);

          // Simpan data ke dalam SharedPreferences
          await prefs.setString('surat_permohonan', jsonData);

          return SuratPermohonan.fromJson(data);
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



  //local

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _getProfile.getProfileDataFromPreferences();

    setState(() {

      _profileMahasiswa = profile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: FutureBuilder<Krs?>(
              future: _getDataKrs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SiakDrawer(

                    context: context,
                  );
                } else {
                  return const CircularProgressIndicator(
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
                      future: _getDataMahasiswa(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator()); // Tampilkan indikator loading saat data sedang dimuat
                        }
                        if (snapshot.hasError) {
                          return Text('Terjadi kesalahan: ${snapshot.error}'); // Tampilkan pesan kesalahan jika terjadi error
                        }
                        if (snapshot.hasData) {
                          _profileData = snapshot.data!;


                          return SingleChildScrollView(
                            child: Padding(
                                padding: getPadding(left: 26, bottom: 5),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(
                                                "Halo, ${_profileData?.nama ?? ''}!",
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtPoppinsSemiBold20Black900),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: SiakColors.SiakPrimaryLightColor
                                                , // Ganti dengan warna yang diinginkan
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.notification_important_outlined, size: 40, color: SiakColors.SiakPrimary), // Ganti dengan warna ikon yang diinginkan
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => SiakNotifikasi()),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: getPadding(left: 3),
                                              child: Text(
                                                  "Selamat datang kembali civitas!",
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: AppStyle.txtPoppinsSemiBold13)),

                                        ],


                                      ),
                                      const SizedBox(height: 20,),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30),
                                        child: Container(

                                         // margin: getMargin(right: 30),


                                            decoration: AppDecoration
                                                .outlineBluegray700
                                                .copyWith(
                                                borderRadius:
                                                BorderRadiusStyle
                                                    .roundedBorder5),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(

                                                  children: [
                                                    Container(
                                                        child:Column(

                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: getPadding(bottom: 20, left: 10),
                                                              child: CustomAvatar(
                                                                radius: 50,
                                                                imageUrl: _profileData?.foto,
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
                                                                      "${_profileData?.prodi ??''}",
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
                                                  ]
                                              ),
                                            )),
                                      ),
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
                                                  Navigator.of(context).pushReplacementNamed("/RegistrasiPage");
                                                },
                                                child: CustomImageView(
                                                    svgPath: ImageConstant.imgEdit)),
                                            CustomIconButton(
                                                height: 53,
                                                width: 53,
                                                onTap: (){
                                                  Navigator.of(context).pushReplacementNamed("/KRSPage");;
                                                },
                                                margin: getMargin(
                                                    left: 39),
                                                child: CustomImageView(
                                                    svgPath: ImageConstant.imgFile)),
                                            CustomIconButton(
                                                height: 53,
                                                width: 53,
                                                margin: getMargin(
                                                    left: 39),
                                                onTap: () { Navigator.of(context).pushReplacementNamed("/KuitansiPage");
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
                                                 Navigator.of(context).pushReplacementNamed("/NilaiPage");
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
                                                  Navigator.of(context).pushReplacementNamed("/KHSPage");;
                                                },
                                                child: CustomImageView(svgPath: ImageConstant.imgBrowser)),
                                            CustomIconButton(
                                                height: 53,
                                                width: 53,
                                                margin: getMargin(
                                                    left: 40),
                                                onTap: () { Navigator.of(context).pushReplacementNamed("/TranskripPage");
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
                                                  Navigator.of(context).pushReplacementNamed("/AbsensiPage");
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
                                                  Navigator.of(context).pushReplacementNamed("/SPPage");
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
                                                        MaterialPageRoute(builder: (context) =>  SiakNews(urlBerita: 'https://www.ust.ac.id/kabar-unika/',)),

                                                      );
                                                    },
                                                    child: Text(
                                                      "Lihat Semua",
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: AppStyle.txtPoppinsMediumBlue12,
                                                    ),
                                                  ),
                                                )

                                              ])),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Align(
                                            alignment: Alignment
                                                .centerRight,
                                            child: Container(
                                                height: getVerticalSize(
                                                    230),
                                              child: ListView.builder(
                                                padding: getPadding(left: 3, top: 8),
                                                scrollDirection: Axis.horizontal,
                                                itemCount: items.length,
                                                itemBuilder: (context, index) {
                                                  final item = items[index];
                                                  return HomeScreenItemWidget(
                                                    title: item['title']!,
                                                    description: item['description']!,
                                                    url: item['url']!,
                                                  );
                                                },
                                              ),

                                            )
                                        ),
                                      ),

                                      SizedBox(height: 50,)

                                    ]

                                )
                            ),
                          );

                        }
                        return SiakProgressDialog(msg: 'Harap Menunggu', max: 100, progressType: ProgressType.valuable,);
                      }
                      ),

          bottomSheet: SiakBottomSheet(),
        )


         );
  }



  String capitalize(String text) {
    if (text.isEmpty) return '';
    return text.toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

}
