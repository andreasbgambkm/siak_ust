

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/tablecolumn.dart';

class KuitansiTelahDibayarCard extends StatelessWidget {
  final String? no_va;
  final String? nama_jenis_bayar;
  final String? ta;
  final String? jml_bayar;
  final String? status;

  const KuitansiTelahDibayarCard({key, this.no_va, this.nama_jenis_bayar, this.ta, this.jml_bayar, this.status});

  String formatCurrency(String amount) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return currencyFormatter.format(double.parse(amount));
  }

  String getStatusText(String status) {
    return status == "1" ? "Telah Dibayar" : "Belum Dibayar";
  }
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
                      child: Text(no_va.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: SiakColors.SiakBlueLight),),
                    )
                  ]),



                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Jenis Pembayaran"),
                  SiakTableColumn(textColumn: nama_jenis_bayar.toString()),

                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Tahun Ajaran"),
                  SiakTableColumn(textColumn: ta.toString()),

                ]),
                TableRow(children: [
                  SiakTableColumn(textColumn: "Jumlah Bayar"),
                  SiakTableColumn(textColumn: formatCurrency(jml_bayar.toString())),

                ]),
                TableRow(children: [



                  SiakTableColumn(textColumn: "Status"),

                  Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(getStatusText(status.toString()),style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: SiakColors.SiakGreenDark),),
                    )
                  ]),
                ]),





              ],
            ),),


        ],
      ),
    );
  }
}