import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/PdfUrlDownload.dart';
import 'package:siak/model/siak_models/detail_khs.dart';
import 'package:siak/model/siak_models/khs_model.dart';
import 'package:siak/screen/khs/khs.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/title.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class KhsDetailPage extends StatefulWidget {
  final ComboboxKhs comboboxKhs;
  final String token;
  final String idKhs;

  const KhsDetailPage({
    Key? key,
    required this.comboboxKhs,
    required this.token,
    required this.idKhs,
  }) : super(key: key);

  @override
  State<KhsDetailPage> createState() => _KhsDetailPageState();
}

class _KhsDetailPageState extends State<KhsDetailPage> {
  DatabaseHelper _getDetailKHS = DatabaseHelper();
  List<KhsDetail> _khsDetails = [];
 UserSiakDetailKHS? _userKhs;
  double? _progress;
  @override
  void initState() {
    super.initState();
    _loadDataDetailKhsFromServer();
  }

  Future<void> _loadDataDetailKhsFromServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final data = await _getDetailKHS.fetchDetailKhsMahasiswa(token, widget.idKhs);

      if (data != null && data.isNotEmpty) {
        final detailKhsModel = SiakDetailKHSModel.fromJson(data);
        setState(() {
          _khsDetails = detailKhsModel.khs;
          _userKhs = detailKhsModel.user;
        });
      } else {
        // Data kosong, kembalikan list kosong
        Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
      }
    } else {
      // Token tidak ada atau kosong, kembalikan list kosong
      Navigator.of(context).pushNamedAndRemoveUntil('/LoginPage', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Center(child: TitlePage(title: 'Kartu Hasil Studi',)),
              Container(

                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
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
                          child: Text("Npm",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                        )
                      ]),
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(": ${_userKhs?.npm ??''}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                        )
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Nama",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                        )
                      ]),
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(": ${_userKhs?.nama ?? ''}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                        )
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("Program Studi",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                        )
                      ]),
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(": ${_userKhs?.prodi}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                        )
                      ]),
                    ]),
                    TableRow(children: [
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text("IP ",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                        )
                      ]),
                      Column(children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(": ${_userKhs?.ip}",style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),),
                        )
                      ]),
                    ]),




                  ],
                ),
              ),

              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      children:  <Widget>[
                        TableCell(child: Center(child: Text('Kode Matkul', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10),))),
                        TableCell(child: Center(child: Text('Nama Matkul', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text('SKS', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text('Kelas', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text('Semester', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text('Nilai Angka', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text('Nilai Huruf', style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize:10)))),
                      ],
                    ),
                    // Build the rows of the table dynamically based on the data
                    ..._khsDetails.map((khsDetail) => TableRow(
                      children: [
                        TableCell(child: Center(child: Text(khsDetail.kdMatkul,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text(khsDetail.nmMatkul,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text(khsDetail.sks,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text(khsDetail.kelas,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text(khsDetail.semester,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text(khsDetail.nAngka,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                        TableCell(child: Center(child: Text(khsDetail.nilaiHuruf,  style:  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 10)))),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'printButton',
            onPressed: () async {

              ProgressDialog pd = ProgressDialog(context: context);
              pd.show(
                max: 100,
                msg: 'File Downloading...',
                progressType: ProgressType.valuable,
              );

              final response = await _getDetailKHS.fetchDownloadKhsMahasiswa(widget.token, widget.idKhs);
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
                context, MaterialPageRoute(builder: (context) => SiakKHS()),
              );


              // await _printPDF();


            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.cloud_download),
          ),

          SizedBox(height: 50,)
        ],
      ),
      bottomSheet: SiakBottomSheet(),
    );

  }
}
