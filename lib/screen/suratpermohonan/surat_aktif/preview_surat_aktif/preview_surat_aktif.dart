import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/surat_aktif_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/title.dart';


class PreviewSuratAktif extends StatefulWidget {
  @override
  State<PreviewSuratAktif> createState() => _PreviewSuratAktifState();
}

class _PreviewSuratAktifState extends State<PreviewSuratAktif> {

  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadSuratAktifDataFromServer();

  }

  Future<List<SuratAktifItem>> _loadSuratAktifDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchSuratAktifPreview(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final suratAktifItemModel = SuratAktif.fromJson(data);
        return suratAktifItemModel.suratAktifList;
      } else {
        // Data kosong, kembalikan list kosong
        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
        return [];
      }
    } else {
      // Token tidak ada atau kosong, kembalikan list kosong
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/SPPage");
          },
        ),
      ),
      body: Column(
        children: [
          TitlePage(title: 'Preview Surat Aktif'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child :FutureBuilder<List<SuratAktifItem>>(
                future: _loadSuratAktifDataFromServer(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Sedang memuat data
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    // Terjadi error saat memuat data
                    return Center(
                      child: Text('Terjadi kesalahan saat memuat data'),
                    );
                  } else if (snapshot.hasData) {
                    // Data berhasil dimuat
                    final suratAktifItem = snapshot.data!;
                    return suratAktifItem.isEmpty ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(notifkosong, height: 100, width: 100),
                          SizedBox(height: 16),
                          Text(
                            'Belum ada surat aktif',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                        :


                    ListView.builder(
                      itemCount: suratAktifItem.length,
                      itemBuilder: (context, index) {
                        final sAktif = suratAktifItem[index];
                        return Container( // Add 'return' statement here
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SiakCardPreviewSuratAktif(
                                  npm: sAktif.npm.toString(),
                                  tanggal: sAktif.tanggal.toString(),
                                  keperluan: sAktif.keperluan.toString(),
                                  ta: sAktif.ta.toString(),
                                  nama_ortu: sAktif.nmortu.toString()),

                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: SiakColors.SiakPrimary, // Set your desired background color here
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Row(

                                    children: const [
                                      Icon(Icons.pending, color: SiakColors.SiakWhite), // Replace 'Icons.pending' with your desired icon
                                      SizedBox(width: 8),
                                      Text(
                                        'Surat Aktif Menunggu Persetujuan',
                                        style: TextStyle(color: SiakColors.SiakWhite),
                                      ),
                                    ],
                                  ),
                                ),
                              )


                            ],
                          ),
                        );
                      },
                    );

// ... (other code remains the same) ...

                  } else {
                    // Tidak ada data yang ditemukan
                    return Center(

                        child: Column(
                          children: [
                            Container(child: Image.asset(notifkosong, height: 100, width: 100)),

                            Row(
                              children: const [
                                Text(
                                  'Belum ada notifikasi',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        )

                    );
                  }
                },
              ),
            ),
          ),




        ],
      ),
      resizeToAvoidBottomInset: true,
      bottomSheet: SiakBottomSheet(),
    );
  }
}
