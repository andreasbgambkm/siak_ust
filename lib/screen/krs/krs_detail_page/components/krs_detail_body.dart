import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SiakKRSDetail extends StatelessWidget {

  final String urlPdf;
  const SiakKRSDetail({Key? key, required this.urlPdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: SfPdfViewer.network(urlPdf, canShowPaginationDialog: true,),
    );
  }
}
