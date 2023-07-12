import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakRegistrasi extends StatelessWidget {
   SiakRegistrasi({key, this.profileNama, this.profileNpm});

  String? profileNama;
  String? profileNpm;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: TitlePage(title: 'REGISTRASI MAHASISWA',)),
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
                        child: Text("HILSA KRISTIAN SITANGGANG",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
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
                        child: Text("STATUS",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                      )
                    ]),
                    Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("AKTIF",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
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

            Container(

              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child:Text('Regitrasi') ,
                  ),
                  SizedBox(height: 10,),
                  Table(

                    columnWidths: {

                      0: FixedColumnWidth(MediaQuery.of(context).size.width/12),// fixed to 100 width
                      1: FixedColumnWidth(MediaQuery.of(context).size.width/5),
                      2: FixedColumnWidth(MediaQuery.of(context).size.width/6.5),//fixed to 100 width
                      3: FixedColumnWidth(MediaQuery.of(context).size.width/6),//fixed to 100 width
                      4: FixedColumnWidth(MediaQuery.of(context).size.width/4.5),//fixed to 100 width
                    },
                    border: TableBorder.all(
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                    ),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("NO",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),

                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("TAHUN AJARAN",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("STATUS",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("TANGGAL",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("AKSI",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("1",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("20191",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("AKTIF",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("29-08-2019",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("TELAH REGISTRASI",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("1",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("20191",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("AKTIF",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("29-08-2019",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("TELAH REGISTRASI",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("1",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("20191",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("AKTIF",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("29-08-2019",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("TELAH REGISTRASI",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("1",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("20191",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("AKTIF",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("29-08-2019",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                        Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("TELAH REGISTRASI",style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: MediaQuery.of(context).size.width/40),),
                          )
                        ]),
                      ]),



                    ],
                  ),
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