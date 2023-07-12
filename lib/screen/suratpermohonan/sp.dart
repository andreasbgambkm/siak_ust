import 'package:flutter/material.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakSP extends StatelessWidget {
  const SiakSP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitlePage(title:'Surat Permohonan'),
            Text('KHS SEMESTER BERAPA YANG INGIN ANDA LIHAT'),
            Footer()
          ],
        ),
      ),
    );
  }
}