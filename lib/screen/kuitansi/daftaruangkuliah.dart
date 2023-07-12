
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

class KuitansiDaftarUang extends StatelessWidget {
  const KuitansiDaftarUang({key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Center(child: Text('DAFTAR UANG KULIAH',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17)),),
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
                      SiakTableColumn(textColumn: "2018/2019 Ganjil"),

                    ]),
                    TableRow(children: [
                      SiakTableColumn(textColumn: "Batas Awal"),
                      SiakTableColumn(textColumn: "17 September 2019"),

                    ]),
                    TableRow(children: [
                      SiakTableColumn(textColumn: "Batas Akhir"),
                      SiakTableColumn(textColumn: "17 September 2019"),

                    ]),





                  ],
                ),
                SizedBox(height: 10,),
                Center(
                    child:SiakButton(
                        text: 'Download',
                        borderRadius: 8,
                        heightButton: 30, widthButton: 60,
                        onPressedButton: () async {

                          final kuitansi = Kuitansi(
                              nama: 'nama',
                              alamat: 'alamat',
                              prodi: 'prodi',
                              npm: 'npm',
                              fakultas: 'fakultas',
                              tanggal: 'tanggal');

                          final pdfFile = await PdfInvoiceApi.generate(kuitansi);
                          PdfApi.openFile(pdfFile);
                        })
                )
              ],
            ),),

          SiakCard(child: Column(
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
                    SiakTableColumn(textColumn: "2018/2019 Ganjil"),

                  ]),
                  TableRow(children: [
                    SiakTableColumn(textColumn: "Batas Awal"),
                    SiakTableColumn(textColumn: "17 September 2019"),

                  ]),
                  TableRow(children: [
                    SiakTableColumn(textColumn: "Batas Akhir"),
                    SiakTableColumn(textColumn: "17 September 2019"),

                  ]),





                ],
              ),
              SizedBox(height: 10,),
              Center(
                child: Text('Cetak Kuitansi di Menu KRS',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: SiakColors.SiakPrimary)),
              )
            ],
          ), shadow: 2),


          Footer()
        ],
      ),
    );
  }
}