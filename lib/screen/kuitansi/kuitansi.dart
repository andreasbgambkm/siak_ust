import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/daftar_uang_kuliah_model.dart';
import 'package:siak/model/siak_models/kuitansi_telah_dibayar_model.dart';
import 'package:siak/screen/kuitansi/daftaruangkuliah.dart';
import 'package:siak/screen/kuitansi/telahdibayar.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';


class SiakKuitansi extends StatefulWidget {

  @override
  _SiakKuitansiState createState() => _SiakKuitansiState();
}

class _SiakKuitansiState extends State<SiakKuitansi> with SingleTickerProviderStateMixin {
  TabController? tabController;

  DatabaseHelper _databaseHelper = DatabaseHelper();

  KuitansiTelahDibayar? _kuitansiBayar;
  DaftarUangKuliahModel? _daftarUangKuliah;
  List<UangKuliahItem> uangKuliahItemList =[];
  List<UangKuliahDibayar> krsDiambilList =[];
  dynamic token;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _loadTokenDataFromPreferences();
    super.initState();
  }



  Future<List<UangKuliahDibayar>> _loadKuitansiTelahDibayarDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchKuitansiTelahDibayar(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final uangKuliahDibayar = KuitansiTelahDibayar.fromJson(data);
        return uangKuliahDibayar.uangKuliahDibayar;
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


  Future<List<UangKuliahItem>> _loadDaftarUangKuliahDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchDaftarUangKuliah(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final daftarUangKuliah = DaftarUangKuliahModel.fromJson(data);
        return daftarUangKuliah.listUangKuliah;
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
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SiakAppbar(),
      drawer: SiakDrawer(context: context,),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TitlePage(title:'Cetak Kuitansi'),
                ),
                Center(
                  child: Container(
                    // height: 50,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 223, 223, 223),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        TabBar(

                          unselectedLabelColor: Colors.grey,
                          labelColor:SiakColors.SiakPrimaryLightColor,
                          indicatorColor: SiakColors.SiakPrimary,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: SiakColors.SiakPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              child: Text("DAFTAR UANG KULIAH",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width/32),),
                            ),
                            Tab(
                              child: Text("TELAH DIBAYAR",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width/32),),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [

                      FutureBuilder<List<UangKuliahItem>>(
                        future: _loadDaftarUangKuliahDataFromServer(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {

                            final daftarUangKuliah = snapshot.data!;
                            print('cek isi data snapshot');
                            print(daftarUangKuliah);
                            return daftarUangKuliah.isEmpty ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(notifkosong, height: 100, width: 100),
                                  SizedBox(height: 16),
                                  const Text(
                                    'Belum Ada Daftar Uang Kuliah',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),

                            ): SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [



                                  const SizedBox(height: 10),
                                  Center(child: Text('DAFTAR UANG KULIAH',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17)),),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: daftarUangKuliah.length,
                                      itemBuilder: (context, index) {


                                        final listUangKuliah = daftarUangKuliah[index];

                                        return KuitansiDaftarUangCard(
                                          kode_kwitansi: listUangKuliah.kdkwitansi,
                                          no_va: listUangKuliah.noVa,
                                          nama_jenis_bayar: listUangKuliah.namaJenisBayar,
                                          mulai: listUangKuliah.mulai,
                                          batas: listUangKuliah.batas,
                                        );
                                      },

                                    ),
                                  ),



                                  const  SizedBox(height: 200,)

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

                      FutureBuilder<List<UangKuliahDibayar>>(
                        future: _loadKuitansiTelahDibayarDataFromServer(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {

                            final kuitansi = snapshot.data!;
                            print('cek isi data snapshot');
                            print(kuitansi);
                            return kuitansi.isEmpty ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(notifkosong, height: 100, width: 100),
                                  SizedBox(height: 16),
                                  const Text(
                                    'Belum Ada Kuitansi',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),

                            ): SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [



                                  const SizedBox(height: 10),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: kuitansi.length,
                                      itemBuilder: (context, index) {


                                        final kuitansi_dibayar = kuitansi[index];

                                        return KuitansiTelahDibayarCard(
                                          no_va: kuitansi_dibayar.noVa,
                                          nama_jenis_bayar: kuitansi_dibayar.namaJenisBayar,
                                            ta: kuitansi_dibayar.ta,
                                            jml_bayar: kuitansi_dibayar.jlhBayar,
                                          status: kuitansi_dibayar.status,
                                        );
                                      },

                                    ),
                                  ),



                                  const  SizedBox(height: 10,)

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

                    ],



                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SiakBottomSheet(),
    );
  }
}


