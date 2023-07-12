import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:siak/widgets/customdrawer.dart';


class SiakProfile extends StatefulWidget {

  SiakProfile({this.profileNama, this.profileNpm});
  String? profileNama;
  String? profileNpm;

  @override
  _SiakProfileState createState() => _SiakProfileState();
}

class _SiakProfileState extends State<SiakProfile> {

  DatabaseHelper _databaseHelper = DatabaseHelper();
  ProfileMahasiswa? _profileMahasiswa;

  @override
  void initState() {
    super.initState();
    _getData();
    _loadProfileDataFromLocal();
  }

  Future<void> _loadProfileDataFromLocal() async {
    ProfileMahasiswa? profile = await _databaseHelper.getProfileDataFromPreferences();
    setState(() {

      _profileMahasiswa = profile;
    });
  }

  ProfileMahasiswa? _profileData;
  DatabaseHelper _getProfile = DatabaseHelper();
  DatabaseHelper _updateProfile = DatabaseHelper();

  bool isFullNameEditable = true;
  bool isEmailEditable = true;
  bool isPasswordEditable = true;
  bool isLocationEditable = true;

  String npm = "12345678";
  String fullName = "John Doe";
  String birthPlace = "Jakarta";
  String birthDate = "01/01/2000";
  String gender = "Male";
  String religion = "Islam";

  String province = "DKI Jakarta";
  String city = "Jakarta Selatan";
  String subDistrict = "Kebayoran Baru";
  String village = "Gandaria Utara";
  String rtRw = "001/005";

  String fatherName = "John Doe Sr.";
  String motherName = "Jane Doe";
  String parentAddress = "Jl. Contoh Alamat No. 123";
  String fatherOccupation = "Engineer";
  String motherOccupation = "Teacher";
  String parentReligion = "Islam";



  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final data = await _getProfile.fetchProfileMahasiswa(token);
      if (data != null) {
        setState(() {
          _profileData = ProfileMahasiswa.fromJson(data);
        });
      } else {
        print('Gagal mendapatkan data profil');
      }
    }
  }

  Future<void> _updateData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final updatedData = {
        'npm': npm,
        'nama': fullName,
        'tempatLahir': birthPlace,
        'tanggalLahir': birthDate,
        'jenisKelamin': gender,
        'agama': religion,
        'provinsi': province,
        'kabupaten': city,
        'kecamatan': subDistrict,
        'kelurahan': village,
        'rtRw': rtRw,
        'namaAyah': fatherName,
        'namaIbu': motherName,
        'alamatOrtu': parentAddress,
        'pekerjaanAyah': fatherOccupation,
        'pekerjaanIbu': motherOccupation,
        'agamaOrtu': parentReligion,
      };

      final success = await _updateProfile.updateProfileMahasiswa(_profileData!);

      if (success) {
        print('Data berhasil diperbarui');
      } else {
        print('Gagal memperbarui data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(
        onImageTap: () {

        },
        imagePath: 'assets/images/siak_edit_profile.png',
      ),
      drawer: SiakDrawer(context: context, profileNama: _profileData?.nama, profileNpm: _profileData?.npm.toString(),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: ListView(
          children: [
            Text(
              "Profile Mahasiswa",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),

            buildProfileCard(),
            SizedBox(height: 20),

            Text(
              "Alamat",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            buildAddressCard(),
            SizedBox(height: 20),

            Text(
              "Data Orangtua",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            buildParentDataCard(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: SiakColors.SiakPrimary, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    setState(() {
                      isFullNameEditable = false;
                      isEmailEditable = false;
                      isPasswordEditable = false;
                      isLocationEditable = false;
                    });
                  },
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: SiakColors.SiakBlack,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    _updateData();
                  },
                  color: SiakColors.SiakPrimary,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard() {
    if (_profileMahasiswa != null) {
      return Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("NPM", _profileMahasiswa!.npm.toString() ?? '', false, Icons.card_membership),
              buildTextField("Nama", _profileMahasiswa!.nama.toString() ?? '', false, Icons.person),
              buildTextField("Tempat Lahir", _profileMahasiswa!.tempatLahir.toString() ?? '', false, Icons.home_mini),
              buildTextField("Tanggal Lahir", _profileMahasiswa!.tanggalLahir.toString() ?? '', false, Icons.date_range),
              buildTextField("Jenis Kelamin", _profileMahasiswa!.jenisKelamin.toString() ?? '', false, Icons.man),
              buildTextField("Agama", _profileMahasiswa!.agama.toString() ?? '', false, Icons.church),
            ],
          ),
        ),
      );
    } else {
      // Tampilkan indikator loading atau pesan lain saat data sedang diambil
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget buildAddressCard() {
    if(_profileMahasiswa != null){
      return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField("Provinsi", _profileMahasiswa!.provinsi.toString() ?? '', false, Icons.home_work),
                buildTextField("Kabupaten/Kota",_profileMahasiswa!.kabupaten.toString() ?? '',false, Icons.home_work),
                buildTextField("Kecamatan/Kota", _profileMahasiswa!.kecamatan.toString() ?? '', false, Icons.home_work),
                buildTextField("Kelurahan/Desa", _profileMahasiswa!.kelurahanMahasiswa.toString() ?? '',false, Icons.home_work),
                buildTextField("RT/RW", "${_profileMahasiswa!.rtMahasiswa.toString() ?? ''} / ${_profileMahasiswa!.rwMahasiswa.toString() ?? ''}", false, Icons.home_work),
              ],
            ),
          ),
        ),
      );
    } else{
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget buildParentDataCard() {
    if(_profileMahasiswa != null){
      return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField("Nama Ayah", _profileMahasiswa!.namaAyah.toString() ?? '',false, Icons.man_rounded),
              buildTextField("Nama Ibu", _profileMahasiswa!.namaIbu.toString() ?? '', false, Icons.woman),
              buildTextField("Alamat Orangtua", _profileMahasiswa!.alamatOrtu.toString() ?? '', false, Icons.place),
              buildTextField("Pekerjaan Ayah", _profileMahasiswa!.pekerjaanAyah.toString() ?? '', false, Icons.work),
              buildTextField("Pekerjaan Ibu", _profileMahasiswa!.pekerjaanIbu.toString() ?? '', false, Icons.work),
              buildTextField("Agama Orangtua", _profileMahasiswa!.agama.toString() ?? '', false, Icons.church),
            ],
          ),
        ),
      );
    }else{
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget buildTextField(String labelText, String value, bool isEditable, IconData iconData) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(iconData),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              initialValue: value,
              enabled: isEditable,
              decoration: InputDecoration(
                labelText: labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (newValue) {
                // Update the corresponding value based on the label
                setState(() {
                  if (labelText == 'Nama') {
                    fullName = newValue;
                  } else if (labelText == 'Tempat Lahir') {
                    birthPlace = newValue;
                  } else if (labelText == 'Tanggal Lahir') {
                    birthDate = newValue;
                  } else if (labelText == 'Jenis Kelamin') {
                    gender = newValue;
                  } else if (labelText == 'Agama') {
                    religion = newValue;
                  } else if (labelText == 'Provinsi') {
                    province = newValue;
                  } else if (labelText == 'Kabupaten/Kota') {
                    city = newValue;
                  } else if (labelText == 'Kecamatan/Kota') {
                    subDistrict = newValue;
                  } else if (labelText == 'Kelurahan/Desa') {
                    village = newValue;
                  } else if (labelText == 'RT/RW') {
                    rtRw = newValue;
                  } else if (labelText == 'Nama Ayah') {
                    fatherName = newValue;
                  } else if (labelText == 'Nama Ibu') {
                    motherName = newValue;
                  } else if (labelText == 'Alamat Orangtua') {
                    parentAddress = newValue;
                  } else if (labelText == 'Pekerjaan Ayah') {
                    fatherOccupation = newValue;
                  } else if (labelText == 'Pekerjaan Ibu') {
                    motherOccupation = newValue;
                  } else if (labelText == 'Agama Orangtua') {
                    parentReligion = newValue;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
