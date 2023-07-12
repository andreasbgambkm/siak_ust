import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakTranskrip extends StatelessWidget {
  const SiakTranskrip({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitlePage(title: 'Transkrip Sementara'),
            Container(

              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/2.35),
                border: TableBorder.all(
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                ),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("NAMA",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("HILSA KRISTIAN SITANGGANG",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("NPM",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("1908108153",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("PROGRAM STUDI",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("SISTEM INFORMASI",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("SEMESTER",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("6",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Tahun Ajaran",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("2021/2022",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                  ]),




                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                      color: Color.fromARGB(255, 201, 201, 201), width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 201, 201, 201),
                        offset: Offset(4, 4)),
                  ]),
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}