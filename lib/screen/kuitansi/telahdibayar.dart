

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/tablecolumn.dart';

class KuitansiTelahDibayar extends StatelessWidget {
  const KuitansiTelahDibayar({key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Center(child: Text('TELAH DIBAYAR',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17)),),
          SiakCard(
            shadow: 2,
            child: Table(
              defaultColumnWidth: FixedColumnWidth(MediaQuery.of(context).size.width/2.1),
              border: TableBorder.all(
                color: Colors.transparent,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(children: [
                  SiakTableColumn(textColumn: "No.Virtual Account"),
                  Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("32810890232",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: SiakColors.SiakBlueLight),),
                    )
                  ]),



                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Jenis Pembayaran"),
                  SiakTableColumn(textColumn: "Uang Kuliah Pokok"),

                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Tahun Ajaran"),
                  SiakTableColumn(textColumn: "20201"),

                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Jumlah Bayar"),
                  SiakTableColumn(textColumn: "Rp 2.918.798"),

                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Status"),

                  Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Sudah Bayar",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: SiakColors.SiakGreenDark),),
                    )
                  ]),
                ]),





              ],
            ),),

          Footer()
        ],
      ),
    );
  }
}