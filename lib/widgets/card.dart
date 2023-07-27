import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/isi_krs_model.dart';
import 'package:siak/model/siak_models/khs_model.dart';
import 'package:siak/model/siak_models/transkrip_model.dart';
import 'package:siak/screen/khs/khs_detail_page/khs_detail_page.dart';
import 'package:siak/screen/krs/krs_detail_page/krs_detail_page.dart';
import 'package:siak/theme/app_style.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SiakCard extends StatelessWidget {
  final Widget? child;
  final double shadow;
  const SiakCard({key ,required this.child,required this.shadow});

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left:10 ,right: 10),
      alignment: Alignment.topLeft,
      child:child,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
              color: Color.fromARGB(255, 201, 201, 201), width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 201, 201, 201),
                offset: Offset(shadow, shadow)),
          ]),
    );
  }
}

class SiakCardRegistrasi extends StatelessWidget {
  final String no_daftar;
  final String tahun_ajaran;
  final double? width;
  final double? height;
  final String tanggal_registrasi;
  final String status;

  const SiakCardRegistrasi({
    Key? key,
    required this.no_daftar,
    required this.tahun_ajaran,
    required this.tanggal_registrasi,
    required this.status,
    this.width,
    this.height,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              Text(
                'No. Daftar : ',
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                no_daftar,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
              const Spacer(),

              const Text(
                'Tgl Registrasi : ',
                style: TextStyle(

                  color: SiakColors.SiakBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                tanggal_registrasi,
                style: const TextStyle(

                  color: SiakColors.SiakBlack,
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 8),
          child: Column(
            children: <Widget>[


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  if (status == "1")
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                  if (status == "0")
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 30,
                    ),

                  SizedBox(width: 15,),





                  if (status == "1")
                    Text(
                      'Telah Registrasi',
                      style: TextStyle(
                        background: Paint()
                          ..color = Colors.greenAccent
                          ..strokeWidth = 20
                          ..strokeJoin = StrokeJoin.round
                          ..strokeCap = StrokeCap.round
                          ..style = PaintingStyle.stroke,
                        color: SiakColors.SiakWhite,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (status == "0")
                    Text(
                      'Belum Registrasi',
                      style: TextStyle(
                        background: Paint()
                          ..color = Colors.greenAccent
                          ..strokeWidth = 20
                          ..strokeJoin = StrokeJoin.round
                          ..strokeCap = StrokeCap.round
                          ..style = PaintingStyle.stroke,
                        color: SiakColors.SiakWhite,
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const Spacer(),

                  const Text(
                    'T.A : ',
                    style:  TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tahun_ajaran,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),



                ],
              ),

              const SizedBox(
                width: 100,
                height: 10,
              ),
            ],
          ),
        ),
        onTap: () {
          // Aksi yang akan dilakukan ketika card ditekan
        },
      ),
    );
  }
}

class CardSuratPermohonan extends StatelessWidget {
  final String idSurat;
  final String jenisSurat;
  final String routes;

  const CardSuratPermohonan({required this.idSurat, required this.jenisSurat, required this.routes});

  @override
  Widget build(BuildContext context) {
    return ClipRect(

      child: Container(
        child: GestureDetector(
          onTap: (){

            Navigator.of(context).pushReplacementNamed("/${routes}");


          },
          child: Card(
            elevation: 5,

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.email,
                    size: 40,
                    color: SiakColors.SiakPrimary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    idSurat,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      jenisSurat,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}

class SPWelcomingCard extends StatelessWidget {

  final String? nama;
  final String? msg;
  final double? height;

  const SPWelcomingCard({super.key, required this.nama, this.msg, this.height});



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: SiakColors.SiakPrimary.withAlpha(180), blurRadius: 1)
                  ]),
              child: Align(
                alignment: Alignment.centerRight,
                child:  Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text("Hai Kak ${nama}! \n ${msg}",style: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.bold, color: SiakColors.SiakPrimaryLightColor),),
                ),
              ),
            ),
          ),
          Container(

            child: Image.asset(WelcomingSP),
          )

        ],
      ),
    );
  }
}


class SiakCardRiwayatKRS extends StatefulWidget {
  final String id_krs;
  final String tahun_ajaran;
  final double? width;
  final double? height;
  final String semester;
  final String token;


  const SiakCardRiwayatKRS({
    Key? key,
    required this.id_krs,
    required this.tahun_ajaran,
    required this.semester,
    this.width,
    this.height,
    required this.token,
  }) : super(key: key);

  @override
  State<SiakCardRiwayatKRS> createState() => _SiakCardRiwayatKRSState();
}

class _SiakCardRiwayatKRSState extends State<SiakCardRiwayatKRS> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const Text(
                    'ID Krs : ',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.id_krs,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  const Spacer(),

                  const Text(
                    'Semester : ',
                    style: TextStyle(

                      color: SiakColors.SiakBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.semester,
                    style: const TextStyle(

                      color: SiakColors.SiakBlack,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            subtitle: Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 8),
              child: Column(
                children: <Widget>[


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[


                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),

                      SizedBox(width: 15,),

                        Text(
                          'Telah Divalidasi',
                          style: TextStyle(
                            background: Paint()
                              ..color = SiakColors.SiakGreenDark
                              ..strokeWidth = 20
                              ..strokeJoin = StrokeJoin.round
                              ..strokeCap = StrokeCap.round
                              ..style = PaintingStyle.stroke,
                            color: SiakColors.SiakWhite,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                      const Spacer(),

                      const Text(
                        'T.A : ',
                        style:  TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.tahun_ajaran,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),



                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 15,),
                      const Spacer(),

                      InkWell(
                        onTap: () async {
                          ProgressDialog pd = ProgressDialog(context: context);
                          pd.show(
                            max: 100,
                            msg: 'Harap Menunggu...',
                            progressType: ProgressType.valuable,
                          );

                          await _databaseHelper.fetchDetailKrsMahasiswa(widget.token, widget.id_krs);
                          print(widget.token);
                          print(widget.id_krs);

                          final fileUrl = await _databaseHelper.fetchUrlKrsMahasiswa(widget.token, widget.id_krs);
                          pd.close();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KrsDetailPage(urlPdf: fileUrl, token: widget.token, idKrs: widget.id_krs,) ),
                          );
                        },
                        borderRadius: BorderRadius.circular(8), // Sudut melengkung pada InkWell
                        splashColor: SiakColors.SiakPrimary,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Text(
                                'Lihat KRS',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              SizedBox(width: 8), // Jarak antara ikon dan teks "Lihat KRS"

                              Icon(
                                Icons.visibility_rounded,
                                color: Colors.blue, // Warna ikon mata (view) biru
                              ),
                            ],
                          ),
                        ), // Warna latar belakang ketika ditekan
                      )




                    ],
                  ),

                  const SizedBox(
                    width: 100,
                    height: 10,
                  ),
                ],
              ),
            ),
            onTap: () async {

              // Aksi yang akan dilakukan ketika card ditekan
              ProgressDialog pd = ProgressDialog(context: context);
              pd.show(
                max: 100,
                msg: 'Harap Menunggu...',
                progressType: ProgressType.valuable,
              );

              await _databaseHelper.fetchDetailKrsMahasiswa(widget.token, widget.id_krs);
              print(widget.token);
             print(widget.id_krs);

              final fileUrl = await _databaseHelper.fetchUrlKrsMahasiswa(widget.token, widget.id_krs);
               pd.close();
              Navigator.push(context, MaterialPageRoute(builder: (context) => KrsDetailPage(urlPdf: fileUrl, token: widget.token, idKrs: widget.id_krs,) ),
        );
        }

          ),
        ),
      ),
    );
  }


}


class SiakCardTranskrip extends StatelessWidget {
  final TranskripNilai transkripNilai;

  SiakCardTranskrip({Key? key, required this.transkripNilai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bobot;
    double kxb;
    int kredit = int.parse(transkripNilai.sks);

    if (transkripNilai.nilaiHuruf == 'A'){
      bobot = 4;
      kxb = kredit * bobot;
    }
    else if(transkripNilai.nilaiHuruf == "B+"){
      bobot = 3.5;
      kxb = kredit * bobot;
    }
    else if(transkripNilai.nilaiHuruf == 'B'){
      bobot =3;
      kxb = kredit * bobot;

    }
    else if(transkripNilai.nilaiHuruf == 'C+'){
      bobot =2.5;
      kxb = kredit * bobot;

    }
    else if(transkripNilai.nilaiHuruf == 'C'){
      bobot =3;
      kxb = kredit * bobot;

    }
    else if (transkripNilai.nilaiHuruf == 'D'){
      bobot = 2.5;
      kxb = kredit * bobot;
    }
    else if (transkripNilai.nilaiHuruf == 'E'){
      bobot = 0;
      kxb = kredit * bobot;
    }
    else{
      bobot = 0;
      kxb = 0;
    }
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: SiakColors.SiakPrimary, // Warna latar belakang utama Card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [SiakColors.SiakWhite, SiakColors.SiakPrimaryLightColor], // Warna gradien dari atas ke bawah
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: SiakColors.SiakBlack, // Warna border Card
            width: 2,
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.school_rounded, color: SiakColors.SiakPrimary,),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: SiakColors.SiakPrimary, // Warna latar belakang lingkaran teks
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    transkripNilai.nmMatkul,
                    style: const TextStyle(
                      color: SiakColors.SiakWhite, // Warna teks
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),



          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      'Kode Matkul: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: SiakColors.SiakBlack, // Warna teks
                      ),
                    ),
                    Text(
                      transkripNilai.kdMatkul,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: SiakColors.SiakBlack, // Warna teks
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Semester: ',
                      style: TextStyle(
                        color: SiakColors.SiakBlack, // Warna teks
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      transkripNilai.semester,
                      style: const TextStyle(
                        color: SiakColors.SiakBlack, // Warna teks
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "K x B :   ${kxb.toString()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: SiakColors.SiakBlack, // Warna teks
                      ),
                    ),
                    const Spacer(),

                    const Text(
                      'SKS: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Warna teks
                      ),
                    ),
                    Text(
                      transkripNilai.sks ,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Warna teks
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Kelas :   ${transkripNilai.kelas }",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: SiakColors.SiakBlack, // Warna teks
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: SiakColors.yellow300, // Warna latar belakang lingkaran teks
                      ),
                      child: Text(
                        transkripNilai.nilaiHuruf ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: SiakColors.SiakBlack, // Warna teks
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 100,
                  height: 10,
                ),
              ],
            ),
          ),
          onTap: () async {


          },
        ),
      ),
    );





  }
}




class SiakCardRiwayatKHS extends StatelessWidget {
  final ComboboxKhs comboboxKhs;
  final String token;

  SiakCardRiwayatKHS({Key? key, required this.comboboxKhs, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: SiakColors.SiakPrimary, // Warna latar belakang utama Card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [SiakColors.SiakPrimary, SiakColors.SiakPrimaryLightColor], // Warna gradien dari atas ke bawah
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: SiakColors.SiakLightColor, // Warna border Card
            width: 2,
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                const Text(
                  'Id KHS : ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks
                  ),
                ),
                Text(
                  comboboxKhs.id,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white, // Warna teks
                  ),
                ),
                const Spacer(),
                const Text(
                  'Semester: ',
                  style: TextStyle(
                    color: Colors.teal, // Warna teks
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  comboboxKhs.semester,
                  style: const TextStyle(
                    color: Colors.teal, // Warna teks
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[

                    Text(
                      'Tahun Ajaran: ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:SiakColors.SiakWhite, // Warna teks
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.school_rounded, color: SiakColors.SiakWhite,),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang lingkaran teks
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        comboboxKhs.tahunAjaran,
                        style: const TextStyle(
                          color: Colors.blue, // Warna teks
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 100,
                  height: 10,
                ),
              ],
            ),
          ),
          onTap: () async {
            final DatabaseHelper _databaseHelper = DatabaseHelper();
            await _databaseHelper.fetchDetailKhsMahasiswa(token, comboboxKhs.id);
            print(token);

            print(comboboxKhs.id);

           // final fileUrl = await _databaseHelper.fetchUrlKrsMahasiswa(token, comboboxKhs.id);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KhsDetailPage(comboboxKhs: comboboxKhs, token: token, idKhs: comboboxKhs.id,) ),
            );
          },
        ),
      ),
    );





  }
}

class SiakTableDetailKHS extends StatelessWidget {
  final String kode_matkul;
  final String nama_matkul;
  final double? width;
  final double? height;
  final String sks;
  final String semester;
  final double nilai_angka;
  final double nilai_huruf;
  final String token;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  SiakTableDetailKHS({
    Key? key,
    required this.semester,
    this.width,
    this.height,
    required this.token,
    required this.kode_matkul,
    required this.nama_matkul,
    required this.sks,
    required this.nilai_angka,
    required this.nilai_huruf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Table();
  }


//downloadKRS


}

class SiakCardIsiKrs extends StatelessWidget {
  final JadwalKRS jadwalKrs;
  final bool Function(int) isChecked;
  final void Function(bool, int) onChanged;


  SiakCardIsiKrs({
    required this.jadwalKrs,
    required this.isChecked,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Radius untuk melengkungkan sudut Card
        side: BorderSide(color: Colors.black, width: 1.0), // Border di sekeliling Card
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.yellow.shade200,
                    child: Row(
                      children: [
                        Text(
                          "${jadwalKrs.id}   ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: SiakColors.SiakPrimary,
                          ),
                        ),
                        Text(
                          "${jadwalKrs.nmMatkul}",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Semester : ${jadwalKrs.semester}   ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      Text(
                        "Hari/Jam : ${jadwalKrs.hari}/ ${jadwalKrs.kdJam}  ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal,),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Sks : ${jadwalKrs.sks}   ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      Text(
                        "Kelas : ${jadwalKrs.kelas}  ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal,),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Dosen : ${jadwalKrs.dosen}   ",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isChecked(jadwalKrs.id),
              activeColor: SiakColors.SiakPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              onChanged: (value) => onChanged(value ?? false, jadwalKrs.id),
            ),
          ],
        ),
      ),
    );
  }

}

class SiakCardPreviewSuratAktif extends StatelessWidget {
  final String npm;
  final String tanggal;
  final String keperluan;
  final String ta;
  final String nama_ortu;

  SiakCardPreviewSuratAktif({Key? key, required this.npm, required this.tanggal, required this.keperluan, required this.ta, required this.nama_ortu, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: SiakColors.SiakPrimary, // Warna latar belakang utama Card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [SiakColors.SiakPrimary, SiakColors.SiakPrimaryLightColor], // Warna gradien dari atas ke bawah
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: SiakColors.SiakLightColor, // Warna border Card
            width: 2,
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                const Text(
                  'Npm : ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks
                  ),
                ),
                Text(
                  npm,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white, // Warna teks
                  ),
                ),
                const Spacer(),
                const Text(
                  'Tanggal: ',
                  style: TextStyle(
                    color: Colors.teal, // Warna teks
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  tanggal,
                  style: const TextStyle(
                    color: SiakColors.SiakBlack, // Warna teks
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  <Widget>[

                    const Text(
                      'Tahun Ajaran  : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: SiakColors.SiakWhite, // Warna teks
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang lingkaran teks
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:
                      Text(
                        ta,
                        style: const TextStyle(
                          color: Colors.blue, // Warna teks
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                  ],
                ),
                const SizedBox(height: 15,),

                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.label_important, color: SiakColors.SiakWhite,),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang lingkaran teks

                      ),
                      child: const Text(
                        'Keperluan  :',
                        style: TextStyle(
                          color: SiakColors.SiakPrimary, // Warna teks
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        "${keperluan}",
                        style: const TextStyle(
                          color: SiakColors.SiakPrimary,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20,),
                Column(
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna latar belakang lingkaran teks

                      ),
                      child: Text(

                       "${keperluan}",
                        style: const TextStyle(
                          color: Colors.blue, // Warna teks
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 100,
                  height: 10,
                ),
              ],
            ),
          ),

        ),
      ),
    );





  }
}

class SiakCardPreviewSuratRiset extends StatelessWidget {
  final String npm;
  final String nama;
  final String fakultas;
  final String prodi;
  final String judul;
  final String tempat_penelitian;
  final String alamat_penelitian ;

  SiakCardPreviewSuratRiset({Key? key, required this.npm, required this.nama, required this.fakultas, required this.prodi, required this.judul, required this.tempat_penelitian, required this.alamat_penelitian,  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: SiakColors.SiakPrimary,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              SiakColors.SiakPrimary,
              SiakColors.SiakPrimaryLightColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: SiakColors.SiakLightColor,
            width: 2,
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[

                const Text(
                  'Nama   : ',
                  style: TextStyle(
                    color: SiakColors.SiakWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    nama,
                    style: const TextStyle(
                      color: SiakColors.SiakWhite,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Npm : ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  npm,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),



              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.school, color: SiakColors.SiakWhite), // Tambahkan ikon sekolah
                    const SizedBox(width: 8),
                    Text(
                      "Fakultas  : ${fakultas}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: SiakColors.SiakWhite,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.school, color: SiakColors.SiakWhite), // Tambahkan ikon sekolah
                    const SizedBox(width: 8),
                    Text(
                      "Prodi         : ${prodi}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: SiakColors.SiakWhite,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.label_important, color: SiakColors.SiakWhite),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        'Tempat Penelitian :',
                        style: TextStyle(
                          color: SiakColors.SiakPrimary,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                            fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${tempat_penelitian}",
                        style: const TextStyle(
                          color: Colors.yellowAccent,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.label_important, color: SiakColors.SiakWhite),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Text(
                        'Alamat Penelitian  :',
                        style: TextStyle(
                          color: SiakColors.SiakPrimary,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${alamat_penelitian}",
                        style: const TextStyle(
                          color: Colors.teal,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}