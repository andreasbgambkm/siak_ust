
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/notifikasi_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/title.dart';

class SiakNotifikasi extends StatefulWidget {
  @override
  State<SiakNotifikasi> createState() => _SiakNotifikasiState();
}

class _SiakNotifikasiState extends State<SiakNotifikasi> {
  DatabaseHelper _getNotif = DatabaseHelper();

  Future<List<Pengumuman>> _loadNotificationsDataFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    if (token != null && token.isNotEmpty) {
      final data = await _getNotif.fetchNotifikasiSiak(token);

      print(data);

      if (data != null && data.isNotEmpty) {
        print(data);
        final siakNotifModel = SiakNotifikasiModel.fromJson(data);
        return siakNotifModel.pengumuman;
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
      appBar: SiakAppbar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const TitlePage(
                title: 'Berita Terkini',
              ),
              Expanded(
                child: FutureBuilder<List<Pengumuman>>(
                  future: _loadNotificationsDataFromServer(),
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
                      final notifications = snapshot.data!;
                      return notifications.isEmpty ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(notifkosong, height: 100, width: 100),
                            SizedBox(height: 16),
                            Text(
                              'Belum ada notifikasi',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                          : ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notifSiak = notifications[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ListTile(
                              tileColor: SiakColors.blueGray100.withAlpha(90),
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                              leading: Container(
                                height: 100,
                                child: CircleAvatar(
                                  backgroundColor: SiakColors.SiakLightColor,
                                  radius: 20,
                                  child: Image.asset(logoUnika),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notifSiak.isi,
                                    maxLines: 5,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
            ],
          ),
        ),
      ),
    );
  }
}




