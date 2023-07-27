
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/data/kuitansi/data_kuitansi.dart';
import 'package:siak/pdf/pdf_api.dart';
import 'package:siak/pdf/pdf_invoice_api.dart';
import 'package:siak/widgets/button.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/tablecolumn.dart';

import '../../widgets/footer.dart';

class KuitansiDaftarUangCard extends StatelessWidget {
  final String? kode_kwitansi;
  final String? no_va;
  final String? nama_jenis_bayar;
  final String? mulai;
  final String? batas;

  const KuitansiDaftarUangCard({key, this.kode_kwitansi, this.no_va, this.nama_jenis_bayar, this.mulai, this.batas});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),

          SiakCard(
            shadow: 2,
            child:Column(
              children: [
                Table(
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
                          child: Text(no_va.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: SiakColors.SiakBlueLight),),
                        )
                      ]),



                    ]),
                    TableRow(children: [
                      SiakTableColumn(textColumn: "Jenis Pembayaran"),
                      Center(child: SiakTableColumn(textColumn: nama_jenis_bayar.toString())),

                    ]),
                    TableRow(children: [
                      SiakTableColumn(textColumn: "Tahun Ajaran"),
                      SiakTableColumn(textColumn: "-"),

                    ]),
                    TableRow(children: [
                      SiakTableColumn(textColumn: "Batas Awal"),
                      SiakTableColumn(textColumn: mulai.toString()),

                    ]),
                    TableRow(children: [
                      SiakTableColumn(textColumn: "Batas Akhir"),
                      SiakTableColumn(textColumn: batas.toString()),

                    ]),





                  ],
                ),
                SizedBox(height: 10,),

              ],
            ),),


        ],
      ),
    );
  }
}