import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/screen/kuitansi/daftaruangkuliah.dart';
import 'package:siak/screen/kuitansi/telahdibayar.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';


class SiakKuitansi extends StatefulWidget {

  @override
  _SiakKuitansiState createState() => _SiakKuitansiState();
}

class _SiakKuitansiState extends State<SiakKuitansi> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SiakAppbar(),
      drawer: SiakDrawer(context: context,),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TitlePage(title:'Cetak Kuitansi'),
              Center(
                child: Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.width/1.05,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 223, 223),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      TabBar(

                        unselectedLabelColor: Colors.grey,
                        labelColor:SiakColors.SiakPrimaryLightColor,
                        indicatorColor: SiakColors.SiakPrimary,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: SiakColors.SiakPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            child: Text("DAFTAR UANG KULIAH",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width/32),),
                          ),
                          Tab(
                            child: Text("TELAH DIBAYAR",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width/32),),

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [

                    KuitansiDaftarUang(),
                    KuitansiTelahDibayar()
                  ],



                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


