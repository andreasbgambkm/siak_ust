import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/PdfUrlDownload.dart';
import 'package:siak/screen/krs/krs.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'components/krs_detail_body.dart';

class KrsDetailPage extends StatefulWidget {

  final String urlPdf;
  final String token;
  final String idKrs;

  late ProgressDialog pd;

  KrsDetailPage({
    Key? key,
    required this.urlPdf,
    required this.token,
    required this.idKrs,
  }) : super(key: key);
  @override
  State<KrsDetailPage> createState() => _KrsDetailPageState();
}

class _KrsDetailPageState extends State<KrsDetailPage> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  double? _progress;

  @override
  void initState() {
    widget.urlPdf;
    print(widget.urlPdf);
    widget.pd = ProgressDialog(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(),
      backgroundColor: SiakColors.SiakWhite,
      body: SiakKRSDetail(urlPdf: widget.urlPdf,),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget> [
          //downloader without dio
     FloatingActionButton(
            heroTag: 'printButton',
            onPressed: () async {

              ProgressDialog pd = ProgressDialog(context: context);
             pd.show(
                max: 100,
                msg: 'File Downloading...',
                progressType: ProgressType.valuable,
              );

              final response = await _databaseHelper.fetchDetailKrsMahasiswa(widget.token, widget.idKrs);
              final pdfDownloadResponse = PdfDownloadUrl.fromJson(response);
              String fileUrl = pdfDownloadResponse.file;
              print(fileUrl);

              FileDownloader.downloadFile(
                  url: fileUrl,
                  onProgress: (name, progress){
                    setState(() {
                      _progress = progress;
                    });

                  },
                onDownloadCompleted: (value){
                  print('path  $value ');
                  setState(() {
                    _progress = null;
                  });

                });

              Fluttertoast.showToast(msg: 'Download complete!', toastLength: Toast.LENGTH_SHORT);
              pd.close();
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => SiakKRS()),
              );


              // await _printPDF();


            },
            backgroundColor: SiakColors.black9003f,
            child: const Icon(Icons.print_rounded),
          ),
          const SizedBox(height: 30,),
          //download using dio package
          FloatingActionButton(
            heroTag: 'downloadButton',
            onPressed: () async {
              ProgressDialog pd = ProgressDialog(context: context);
              pd.show(
                max: 100,
                msg: 'File Downloading...',
                progressType: ProgressType.valuable,
              );

              final response = await _databaseHelper.fetchDetailKrsMahasiswa(widget.token, widget.idKrs);
              final pdfDownloadResponse = PdfDownloadUrl.fromJson(response);
              String fileUrl = pdfDownloadResponse.file;
              print(fileUrl);

              await download(fileUrl, widget.idKrs.toString());
              print(widget.idKrs);

              // Tampilkan toast bahwa unduhan telah selesai
              Fluttertoast.showToast(msg: 'Download complete!', toastLength: Toast.LENGTH_SHORT);
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => SiakKRS()),
              );

              // Tutup dialog setelah unduhan selesai
              pd.close();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.cloud_download),
          ),
        ],
      ),

      bottomSheet: SiakBottomSheet(),

    );
  }
  Future<void> download(String url, String filename) async {
    final directory = await getExternalStorageDirectory();
    final savePath = '${directory?.path}/$filename.pdf';
    final dio = Dio();
    dio.interceptors.add(LogInterceptor());
    try {
      final response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(seconds: 1),
        ),
      );
      final file = File(savePath);
      final raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      // Periksa apakah file sudah ada sebelum membukanya
      if (await file.exists()) {
        // Jika file sudah ada, Anda bisa membuka file tersebut
        // Misalnya, jika Anda ingin membuka PDF menggunakan SfPdfViewer:
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => SiakKRS()),
        );



      } else {
        debugPrint('File not found: $savePath');
      }
    } catch (e) {
      debugPrint(e.toString());


    }
  }


  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  Future<void> _printPDF() async {


    final directory = await getExternalStorageDirectory();
    final pdfPath = '${directory?.path}/${widget.idKrs}.pdf';
    final file = File(pdfPath);

    final raf = file.openSync(mode: FileMode.read);
    // response.data is List<int> type
    print(pdfPath);
    raf.readByteSync();
    await raf.close();

    // Periksa apakah file sudah ada sebelum membukanya
    if (await file.exists()) {
      SfPdfViewer.file(
        File(pdfPath),
      );



    } else {
      debugPrint('File not found: $pdfPath');
    }
    



  }
}
