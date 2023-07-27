import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/surat_permohonan.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/custom_bottomsheet.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/footer.dart';
import 'package:siak/widgets/title.dart';

class SiakSP extends StatefulWidget {
  const SiakSP({Key? key}) : super(key: key);

  @override
  State<SiakSP> createState() => _SiakSPState();
}

class _SiakSPState extends State<SiakSP> {

  List<DaftarSurat> daftarSurat = [];
  DaftarSurat? selectedSurat;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  SuratPermohonan? sp;
  ProfileMahasiswa? _profileMahasiswa;

  @override
  void initState() {
    super.initState();
    _loadSuratPermohonanDataFromLocal();
    _loadProfileDataFromLocal();
  }

  Future<void> _loadSuratPermohonanDataFromLocal() async {
    SuratPermohonan? sp = await _databaseHelper.getSuratPermohonanDataFromPreferences();
    setState(() {
      daftarSurat = sp?.daftarSurat ??[];
      selectedSurat = daftarSurat.isNotEmpty ? daftarSurat[0]: null;

    });
  }
  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _databaseHelper.getProfileDataFromPreferences();

    setState(() {

      _profileMahasiswa = profile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SiakDrawer(context: context,),
      appBar: SiakAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Center(child: TitlePage(title:'Surat Permohonan')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SPWelcomingCard(nama: _profileMahasiswa?.nama, height: 175, msg: "Btw mau ngurus surat apa nih?",)
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: daftarSurat.length,

                  itemBuilder: (context, index) {
                    final listSuratPermohonan = daftarSurat[index];
                    return CardSuratPermohonan(
                      idSurat: listSuratPermohonan.idSurat,
                      jenisSurat: listSuratPermohonan.jenisSurat,
                      routes: listSuratPermohonan.idSurat,
                    );
                  },
                ),

                SizedBox(height: 50,)

              ],
            ),
          ),
        ),
      ),
      bottomSheet: SiakBottomSheet(),
    );

  }
}
