import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/isi_krs_model.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/card.dart';
import 'package:siak/widgets/customdrawer.dart';
import 'package:siak/widgets/title.dart';

class SiakIsiKRS extends StatefulWidget {



  @override
  State<SiakIsiKRS> createState() => _SiakIsiKRSState();
}

class _SiakIsiKRSState extends State<SiakIsiKRS> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;
  Krs? _krs;
  IsiKRSModel? _isiKrs;
  List<Combobox> comboKrsList = [];
  List<JadwalKRS> jadwalKrsList =[];
  List<int> selectedJadwalIds = [];

  List<int> selectedIds = [];
  bool isDataLoaded = false;
  Combobox? selectedKrs;
  dynamic token;
  TextEditingController searchController = TextEditingController();
  String selectedKelas = '';
  int selectedSks = 0;
  int totalSKSIsiKRS = 0;
  int selectedSemester = 0;
  String searchKeyword = '';
  bool resetChecked = false;


  void _applyFilters() {
    List<JadwalKRS> filteredList = _isiKrs?.krs ?? [];

    // Filter berdasarkan kelas
    if (selectedKelas.isNotEmpty) {
      filteredList = filteredList
          .where((jadwalKrs) => jadwalKrs.kelas.toLowerCase().contains(selectedKelas.toLowerCase()))
          .toList();
    }

    // Filter berdasarkan SKS
    if (selectedSks > 0) {
      filteredList = filteredList.where((jadwalKrs) => jadwalKrs.sks == selectedSks.toString()).toList();
    }

    // Filter berdasarkan semester
    if (selectedSemester > 0) {
      filteredList = filteredList.where((jadwalKrs) => jadwalKrs.semester == selectedSemester.toString()).toList();
    }

    // Tampilkan data yang telah difilter

    // Filter berdasarkan nama mata kuliah
    if (searchKeyword.isNotEmpty) {
      filteredList = filteredList
          .where((jadwalKrs) => jadwalKrs.nmMatkul.toLowerCase().contains(searchKeyword))
          .toList();
    }


    setState(() {
      jadwalKrsList = filteredList;
    });


    print("Selected kelas: $selectedKelas");
    print("Filtered Data: ${jadwalKrsList.map((jadwalKrs) => jadwalKrs.sks).toList()}");

    print("Selected SKS: $selectedSks");
    print("Filtered Data: ${jadwalKrsList.map((jadwalKrs) => jadwalKrs.sks).toList()}");

    print("Selected Semester: $selectedSemester");
    print("Filtered Data: ${jadwalKrsList.map((jadwalKrs) => jadwalKrs.semester).toList()}");

    print("keyword: $searchKeyword");
    print("Filtered Data: ${jadwalKrsList.map((jadwalKrs) => jadwalKrs.nmMatkul).toList()}");

  }


  bool isChecked(int jadwalId) {
    return selectedJadwalIds.contains(jadwalId);
  }


  void toggleReset() {
    setState(() {
      resetChecked = !resetChecked;


      if (resetChecked) {
        // Kode untuk mereset pilihan item
        selectedJadwalIds.clear();
        totalSKSIsiKRS = 0;
        print('cek fungsi reset');
        print(selectedJadwalIds);
        print(totalSKSIsiKRS);
      } else {
        // Kode untuk tidak melakukan apa-apa saat tombol di-reset
      }
    });
  }


  void onChanged(bool value, int jadwalId) {
    setState(() {
      if (value) {
        // Jika checkbox di-check, tambahkan jadwalId ke dalam list selectedJadwalIds
        selectedJadwalIds.add(jadwalId);
      } else {
        // Jika checkbox di-uncheck, hapus jadwalId dari list selectedJadwalIds
        selectedJadwalIds.remove(jadwalId);
      }
    });
  }

  List<int> selectedSKS = [];

  void _onItemChecked(int sks) {
    setState(() {
      if (selectedSKS.contains(sks)) {
        selectedSKS.remove(sks);
      } else {
        selectedSKS.add(sks);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _loadProfileDataFromLocal();
    _loadKrsDataFromLocal();
    _loadTokenDataFromPreferences();
    _loadIsiKrsDataFromLocal();
  }

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _databaseHelper.getProfileDataFromPreferences();

    setState(() {
      _profileMahasiswa = profile;
    });
  }
  Future<void> _loadKrsDataFromLocal() async {
    Krs? krs = await _databaseHelper.getKrsDataFromPreferences();
    setState(() {
      _krs = krs;
      comboKrsList = krs?.combobox ?? [];
      selectedKrs = comboKrsList.isNotEmpty ? comboKrsList[0] : null;
    });
  }
  Future<void> _loadTokenDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenData = prefs.getString('token');
    print("Di bawah ini merupakan token dari local");
    print(tokenData);

    if (tokenData != null && tokenData.isNotEmpty) {
      setState(() {
        token = tokenData;
      });
    }
  }

  Future<void> _loadIsiKrsDataFromLocal() async {
    IsiKRSModel? isiKrs = await _databaseHelper.getIsiKrsDataFromPreferences();
    setState(() {
      _isiKrs = isiKrs;
      jadwalKrsList = isiKrs?.krs?? [];

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: SiakAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[



            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  const Center(
                    child: TitlePage(
                      title: 'Kartu Rencana Studi',
                    ),
                  ),
                  SiakCard(
                    shadow: 2,
                    child: Column(
                      children:<Widget> [
                        Table(
                          defaultColumnWidth:
                          FixedColumnWidth(MediaQuery.of(context).size.width / 2.35),
                          border: TableBorder.all(
                            color: Colors.transparent,
                            style: BorderStyle.solid,
                          ),
                          children: [
                            TableRow(
                              children: [
                                Column(
                                  children:<Widget> [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Nama",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ": ${_profileMahasiswa?.nama}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Npm",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ": ${_profileMahasiswa?.npm}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Program Studi",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ": ${_krs?.user.prodi}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Semester Berjalan",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ": ${_krs?.user.semesterBerjalan}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "IP Semester Lalu",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ": ${_krs?.user.ipSemesterSebelum}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Maksimum SKS",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        ": ${_krs?.user.maksSks}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),


                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),


                      ],
                    ),
                  ),

                  SizedBox(height: 30,),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchKeyword = value.toLowerCase();
                          _applyFilters();
                        });
                      },


                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan nama mata kuliah',
                        prefixIcon: Icon(Icons.search, color: SiakColors.SiakPrimary,),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: SiakColors.SiakPrimary),
                          borderRadius: BorderRadius.circular(20.0), // Atur radius sesuai keinginan
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: SiakColors.SiakPrimary), // Berikan border ketika TextField dalam keadaan fokus
                          borderRadius: BorderRadius.circular(20.0), // Atur radius sesuai keinginan
                        ),
                      ),
                    ),
                  ),

                  // DropdownButton untuk filter pengelompokkan
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        DropdownButton<String>(
                          value: selectedKelas,
                          menuMaxHeight: 150,
                          focusColor: SiakColors.SiakPrimary,
                          icon: Icon(Icons.arrow_drop_down_circle, color: SiakColors.SiakPrimary,),
                          onChanged: (String? newValue) {
                            // Ketika filter kelas berubah, terapkan filter
                            setState(() {
                              selectedKelas = newValue ?? '';
                              _applyFilters();
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: '',
                              child: Text(
                                'Kelas: Semua',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'A',
                              child: Text(
                                'Kelas: A',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'B',
                              child: Text(
                                'Kelas: B',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'C',
                              child: Text(
                                'Kelas: C',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'D',
                              child: Text(
                                'Kelas: D',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            // Tambahkan dropdown item sesuai dengan kelas yang ada
                          ],
                        ),

                        DropdownButton<int>(
                          menuMaxHeight: 150,
                          focusColor: SiakColors.SiakPrimary,
                          icon: Icon(Icons.arrow_drop_down_circle, color: SiakColors.SiakPrimary,),
                          value: selectedSks,
                          onChanged: (int? newValue) {
                            // Ketika filter SKS berubah, terapkan filter
                            setState(()  {
                              selectedSks = newValue ?? 0; // Pastikan selectedSks tidak null
                              _applyFilters();
                            });
                          },
                          items: const [
                            DropdownMenuItem<int>(
                              value: 0,
                              child: Text(
                                'SKS: Semua',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 2,
                              child: Text(
                                'SKS: 2',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 3,
                              child: Text(
                                'SKS: 3',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            // Tambahkan dropdown item sesuai dengan jumlah SKS yang ada

                            DropdownMenuItem<int>(
                              value: 4,
                              child: Text(
                                'SKS: 4',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),

                          ],
                        ),

                        DropdownButton<int>(
                          menuMaxHeight: 150,
                          focusColor: SiakColors.SiakPrimary,
                          icon: Icon(Icons.arrow_drop_down_circle, color: SiakColors.SiakPrimary,),
                          value: selectedSemester,
                          onChanged: (int? newValue) {
                            // Ketika filter semester berubah, terapkan filter
                            setState(()  {
                              selectedSemester = newValue ?? 0;
                              _applyFilters();
                            });
                          },
                          items: const [
                            DropdownMenuItem<int>(
                              value: 0,
                              child: Text(
                                'Semester: Semua',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Text(
                                'Semester: 1',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),

                            DropdownMenuItem<int>(
                              value: 2,
                              child: Text(
                                'Semester: 2',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 3,
                              child: Text(
                                'Semester: 3',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 4,
                              child: Text(
                                'Semester: 4',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 5,
                              child: Text(
                                'Semester: 5',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 6,
                              child: Text(
                                'Semester: 6',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 7,
                              child: Text(
                                'Semester: 7',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),
                            DropdownMenuItem<int>(
                              value: 8,
                              child: Text(
                                'Semester: 8',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: SiakColors.SiakPrimary,
                                ),
                              ),
                            ),


                            // Tambahkan dropdown item sesuai dengan jumlah semester yang ada
                          ],
                        )



                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      height: 40, // Ganti dengan tinggi yang Anda inginkan
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Total SKS Diambil : ${totalSKSIsiKRS}',
                              style: TextStyle(
                                  color:  SiakColors.SiakBlack ,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: toggleReset,
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color:  SiakColors.SiakPrimary ,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),




                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: jadwalKrsList.length,
                      itemBuilder: (context, index) {
                        final jadwalList = jadwalKrsList[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Radius untuk melengkungkan sudut Card
                            side: BorderSide(color: Colors.black, width: 1.0), // Border di sekeliling Card
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.yellow.shade200,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${jadwalList.id}   ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: SiakColors.SiakPrimary,
                                              ),
                                            ),
                                            Text(
                                              "${jadwalList.nmMatkul}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            "Semester : ${jadwalList.semester}   ",
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "Hari/Jam : ${jadwalList.hari}/ ${jadwalList.kdJam}  ",
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            "Sks : ${jadwalList.sks}   ",
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "Kelas : ${jadwalList.kelas}  ",
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            "Dosen : ${jadwalList.dosen}   ",
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  value: isChecked(jadwalList.id),
                                  activeColor: SiakColors.SiakPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value ?? false) {
                                        selectedJadwalIds.add(jadwalList.id);
                                        totalSKSIsiKRS += int.parse(jadwalList.sks.toString());
                                        print(selectedJadwalIds);
                                        print(totalSKSIsiKRS);
                                      } else {
                                        selectedJadwalIds.remove(jadwalList.id);
                                        totalSKSIsiKRS -= int.parse(jadwalList.sks.toString());
                                        print(selectedJadwalIds);
                                        print(totalSKSIsiKRS);
                                      }

                                      if (totalSKSIsiKRS > 24) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Peringatan'),
                                            content: Text('Total SKS melebihi batas (24 SKS)'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      resetChecked = selectedJadwalIds.isEmpty && totalSKSIsiKRS == 0;
                                    });
                                  },
                                ),


                              ],
                            ),
                          ),
                        );
                      },

                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        print('Cek jadwal id :  ');
                        print(selectedJadwalIds);
                        print(totalSKSIsiKRS);

                        // Periksa apakah tidak ada mata kuliah yang dipilih dan total SKS isi KRS adalah 0
                        if (selectedJadwalIds.isEmpty && totalSKSIsiKRS == 0) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Peringatan'),
                              content: Text('Anda Belum Mengambil Mata Kuliah Apapun'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );

                          // Set resetChecked menjadi true karena belum ada mata kuliah yang dipilih
                          setState(() {
                            resetChecked = true;
                          });
                        } else {
                          // Lakukan aksi Anda jika mata kuliah sudah dipilih
                          double? ipMahasiswa = _isiKrs?.user.ipSemesterSebelum;
                          int? maxSks = _isiKrs?.user.maksSks;

                          //validasi ip dan sks
                          if (ipMahasiswa != null && maxSks != null) {
                            if (ipMahasiswa < 3.0 && maxSks > 20) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Peringatan'),
                                  content: Text('IP Mahasiswa < 3.0 dan total SKS melebihi 20'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else if (ipMahasiswa > 3.0 && maxSks > 24) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Peringatan'),
                                  content: Text('Total SKS melebihi 24'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // Proceed with your action if validation passes
                              _databaseHelper.postIsiKrs(selectedJadwalIds, token);
                              Navigator.of(context).pushReplacementNamed("/KRSDiambilPage");
                            }
                          } else {
                            // Handle the case when ipMahasiswa or maxSks is null
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: SiakColors.SiakPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(double.infinity, 50), // Tambahkan ketinggian (height) di sini
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_box_outlined),
                          SizedBox(width: 8), // Jarak antara ikon dan teks
                          Text('Ambil KRS'),
                        ],
                      ),
                    ),
                  ),

                  const  SizedBox(height: 10,)

                ],
              ),
            ),

          ],
        ),
      ),
      resizeToAvoidBottomInset: true,

    );
  }
}
