import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakKHS extends StatelessWidget {
  const SiakKHS({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitlePage(title: 'Kartu Hasil Studi'),
            Text(
              "KHS SEMESTER BERAPA YANG  INGIN ANDA LIHAT?",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 201, 201, 201),
              ),
              child: DropdownButton<String>(
                hint: Text(
                  "PILIH KHS",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                items: <String>[
                  '2021/2022 - GENAP',
                  '2021/2022 - GANJIL',
                  '2020/2021 - SP',
                  '2020/2021 - GENAP',
                  '2020/2021 - GANJIL',
                  '2019/2020 - SP',
                  '2019/2020 - GENAP',
                  '2019/2020 - GANJIL'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          value,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  // setState(() {});
                },
              ),
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}
