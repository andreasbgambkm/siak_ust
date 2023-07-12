import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:siak/model/data/kuitansi/data_kuitansi.dart';

import 'pdf_api.dart';

class PdfInvoiceApi {
  static Future<File> generate(Kuitansi kuitansi) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(kuitansi),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(kuitansi),
        // buildInvoice(kuitansi),
        Divider(),
        buildTotal(kuitansi),
      ],
      footer: (context) => buildFooter(kuitansi),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Kuitansi kuitansi) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // buildSupplierAddress(),
          Container(
            height: 50,
            width: 50,
            child: BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: kuitansi.fakultas,
            ),
          ),
        ],
      ),
      SizedBox(height: 1 * PdfPageFormat.cm),
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // buildCustomerAddress(kuit),
          // buildInvoiceInfo(kuitansi.tanggal),
        ],
      ),
    ],
  );

  static Widget buildCustomerAddress(Kuitansi kuitansi) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(kuitansi.npm, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(kuitansi.prodi),
    ],
  );

  static Widget buildInvoiceInfo(Kuitansi k) {
    // final paymentTerms = '${k.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      // info.number,
      // Utils.formatDate(info.date),
      // paymentTerms,
      // Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Kuitansi s) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(s.nama, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 1 * PdfPageFormat.mm),
      Text(s.alamat),
    ],
  );

  static Widget buildTitle(Kuitansi l) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Text(l.alamat),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  // static Widget buildInvoice(Kuitansi m) {
  //   final headers = [
  //     'Description',
  //     'Date',
  //     'Quantity',
  //     'Unit Price',
  //     'VAT',
  //     'Total'
  //   ];
  //   final data = Kuitansi.items.map((item) {
  //     final total = item.unitPrice * item.quantity * (1 + item.vat);
  //
  //     return [
  //       item.description,
  //       Utils.formatDate(item.date),
  //       '${item.quantity}',
  //       '\$ ${item.unitPrice}',
  //       '${item.vat} %',
  //       '\$ ${total.toStringAsFixed(2)}',
  //     ];
  //   }).toList();
  //
  //   return Table.fromTextArray(
  //     headers: headers,
  //     data: data,
  //     border: null,
  //     headerStyle: TextStyle(fontWeight: FontWeight.bold),
  //     headerDecoration: BoxDecoration(color: PdfColors.grey300),
  //     cellHeight: 30,
  //     cellAlignments: {
  //       0: Alignment.centerLeft,
  //       1: Alignment.centerRight,
  //       2: Alignment.centerRight,
  //       3: Alignment.centerRight,
  //       4: Alignment.centerRight,
  //       5: Alignment.centerRight,
  //     },
  //   );
  // }

  static Widget buildTotal(Kuitansi g) {
    // final netTotal = g.tanggal
    //     .map((item) => item.unitPrice * item.quantity)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: 'Utils.formatPrice(netTotal)',
                  unite: true,
                ),
                buildText(
                  title: 'Vat "tandadolar" {vatPercent * 100} %',
                  value: 'Utils.formatPrice(vat)',
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: 'Utils.formatPrice(total)',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Kuitansi i) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: 'Address', value: 'invoice.supplier.address'),
      SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(title: 'Paypal', value: 'invoice.supplier.paymentInfo'),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}