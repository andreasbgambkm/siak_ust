
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/krs_diambil.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/screen/krs/isi_krs_page/isi_krs.dart';
import 'package:siak/screen/krs/krs.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/title.dart';

class SiakKRSDiambil extends StatefulWidget {



  @override
  State<SiakKRSDiambil> createState() => _SiakKRSDiambilState();
}

class _SiakKRSDiambilState extends State<SiakKRSDiambil> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  KrsDiambilData? _krsDiambil;
  List<Jadwal> krsDiambilList =[];
  List<int> deletedJadwalIds = [];
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;


  dynamic token;
  String selectedKelas = '';
  int selectedSks = 0;
  int totalSKSDiambil = 0;
  int selectedSemester = 0;
  String searchKeyword = '';




  List<int> selectedSKS = [];

  void _onItemChecked(int sks) {
    setState(() {
      if (selectedSKS.contains(sks)) {
        selectedSKS.remove(sks);
      } else {
        selectedSKS.add(sks);
      }
    });
  }


  Future<void> _refreshData() async {
    setState(() {
      krsDiambilList.clear();
    });


    setState(() {


       _loadKrsAmbilDataFromServer();
    });
  }





  @override
  void initState() {
    super.initState();
    _loadTokenDataFromPreferences();
    _loadKrsAmbilDataFromServer();

  }

  Future<List<KrsDiambilData>> _loadKrsAmbilDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchKrsDiambil(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final krsAmbilModel = KrsDiambilModel.fromJson(data);
        return krsAmbilModel.krsDiambil;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: SiakAppbar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SiakKRS(totalSKSAmbil: totalSKSDiambil,)),
            );
          },
        ),
      ),
      body: FutureBuilder<List<KrsDiambilData>>(
        future: _loadKrsAmbilDataFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final krsAmbil = snapshot.data!;
            totalSKSDiambil = 0;

            for (final krs_ambil in krsAmbil) {
              if (krs_ambil.statusKrs == "Diterima" || krs_ambil.statusKrs == "Belum Divalidasi") {
                totalSKSDiambil += int.parse(krs_ambil.jadwal.sks);
              }
            }
            print('cek isi data snapshot');
            print(krsAmbil);
            return krsAmbil.isEmpty ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(notifkosong, height: 100, width: 100),
                  SizedBox(height: 16),
                  const Text(
                    'Belum ada KRS Diambil',
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
                          title: 'KRS Yang Diambil',
                        ),


                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Total SKS Diambil : ${totalSKSDiambil} SKS   ",
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: krsAmbil.length,
                            itemBuilder: (context, index) {

                               print(krsDiambilList);
                              final krs_ambil = krsAmbil[index];
                               final bool isKrsDiterima = krs_ambil.statusKrs == "Diterima";
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
                                                    "${krs_ambil.jadwal.id}   ",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: SiakColors.SiakPrimary,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${krs_ambil.jadwal.nmMatkul}   ",
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
                                                  "Semester : ${krs_ambil.jadwal.semester}   ",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "Hari/Jam : ${krs_ambil.jadwal.hari}/ ${krs_ambil.jadwal.kdJam}  ",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal,),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  "Sks : ${krs_ambil.jadwal.sks}   ",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "Kelas : ${krs_ambil.jadwal.kelas}  ",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal,),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Dosen : ${krs_ambil.jadwal.dosen}   ",
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                                                ),
                                                Spacer(),

                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: krs_ambil.statusKrs == "Belum Divalidasi" ? Colors.red : Colors.green,
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Text(
                                                    "${krs_ambil.statusKrs}",
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.normal,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),

                                                if (krs_ambil.statusKrs != "Diterima")
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Peringatan'),
                                                            content: Text('Yakin ingin membatalkan mata kuliah ini?'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text('Batal'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                              TextButton(
                                                                child: Text('Ya'),
                                                                onPressed: () async {
                                                                  await  _databaseHelper.deleteKrsDiambil(krs_ambil.jadwal.id.toString(), token);
                                                                  await _refreshData();
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(Icons.delete, color: SiakColors.SiakPrimary),
                                                  ),


                                              ],
                                            ),
                                          ],
                                        ),
                                      ),



                                    ],
                                  ),
                                ),
                              );
                            },

                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              print(deletedJadwalIds);

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Peringatan'),
                                    content: Text('Anda Akan Membatalkan KRS Ini?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );



                            },
                            style: ElevatedButton.styleFrom(
                              primary: SiakColors.SiakPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(width: 8),
                                Text('Batalkan Semua KRS'),
                              ],
                            ),
                          ),
                        ),
                        const  SizedBox(height: 10,)

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

      resizeToAvoidBottomInset: true,

    );
  }
}
