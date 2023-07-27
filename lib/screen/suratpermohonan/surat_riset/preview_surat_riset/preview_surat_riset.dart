import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/surat_aktif_model.dart';
import 'package:siak/model/siak_models/surat_riset_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/custom_table.dart';
import 'package:siak/widgets/title.dart';


class PreviewSuratRiset extends StatefulWidget {
  @override
  State<PreviewSuratRiset> createState() => _PreviewSuratRisetState();
}
class _PreviewSuratRisetState extends State<PreviewSuratRiset> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadSuratRisetDataFromServer();
  }

  Future<SuratRisetModel?> _loadSuratRisetDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final data = await _databaseHelper.fetchSuratRiset(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        return SuratRisetModel.fromJson(data);
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
          TitlePage(title: 'Preview Surat Riset'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<SuratRisetModel?>(
                future: _loadSuratRisetDataFromServer(),
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
                    final suratRisetItem = snapshot.data;
                    if (suratRisetItem == null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(notifkosong, height: 100, width: 100),
                            SizedBox(height: 16),
                            Text(
                              'Belum ada surat riset',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SiakCardPreviewSuratRiset(
                            npm: suratRisetItem.user.npm.toString(),
                            nama: suratRisetItem.user.nama,
                            fakultas: suratRisetItem.user.fakultas,
                            prodi: suratRisetItem.user.prodi,
                            judul: suratRisetItem.user.judul,
                            tempat_penelitian: suratRisetItem.user.tempatPenelitian,
                            alamat_penelitian: suratRisetItem.user.alamatPenelitian,
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: SiakColors.SiakPrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                children: const [
                                  Icon(Icons.pending, color: SiakColors.SiakWhite),
                                  SizedBox(width: 8),
                                  Text(
                                    'Surat Riset Menunggu Persetujuan',
                                    style: TextStyle(color: SiakColors.SiakWhite),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
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
                      ),
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

