import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/model/data/fakultas/fakultas.dart';
import 'package:siak/model/data/mahasiswa/mahasiswa.dart';
import 'package:siak/model/data/prodi/prodi.dart';
import 'package:siak/model/siak_models/fakultas_model.dart';
import 'package:siak/model/siak_models/isi_krs_model.dart';
import 'package:siak/model/siak_models/jurusan_model.dart';
import 'package:siak/model/siak_models/khs_model.dart';
import 'package:siak/model/siak_models/krs_diambil.dart';
import 'package:siak/model/siak_models/krs_model.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';
import 'package:siak/model/siak_models/nilai_uas_model.dart';
import 'package:siak/model/siak_models/nilai_uts_model.dart';
import 'package:siak/model/siak_models/notifikasi_model.dart';
import 'package:siak/model/siak_models/registrasi_model.dart';
import 'package:siak/model/siak_models/surat_permohonan.dart';

class DatabaseHelper{

  var status ;

  var token ;

//READ AND SAVE TOKEN
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }

// A COLLECTION OF FUNCTIONS THAT USED TO REQUEST AND SEND DATA INTO RESTFUL WEB SERVICE AND LOCAL STORAGE
// PROFILE - MAHASISWA
  Future<Map<String, dynamic>> fetchProfileMahasiswa(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$GET_USER_PROFILE'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

// Function to get user data from session or shared preferences
  Future<Map<String, dynamic>?> getSessionOrSharedPreferencesUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('userData');
      if (userData != null) {
        return json.decode(userData);
      }
    } catch (error) {
      throw 'Failed to get user data: $error';
    }
    return null;
  }

  // update profile mahasiswa
  Future<bool> updateProfileMahasiswa(ProfileMahasiswa profileMahasiswa) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      final response = await http.put(
        Uri.parse('$BASE_URL$GET_USER_PROFILE'),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'nama': profileMahasiswa.nama,
          'tempat_lahir': profileMahasiswa.tempatLahir,
          'tanggal_lahir': profileMahasiswa.tanggalLahir,
          'jenis_kelamin': profileMahasiswa.jenisKelamin,
          'agama': profileMahasiswa.agama,
          'provinsi': profileMahasiswa.provinsi,
          'kabupaten': profileMahasiswa.kabupaten,
          'kecamatan': profileMahasiswa.kecamatan,
          'kelurahan': profileMahasiswa.kelurahanMahasiswa,
          'rt': profileMahasiswa.rtMahasiswa,
          'rw': profileMahasiswa.rwMahasiswa,
          'nama_ayah': profileMahasiswa.namaAyah,
          'nama_ibu': profileMahasiswa.namaIbu,
          'alamat_ortu': profileMahasiswa.alamatOrtu,
          'pekerjaan_ayah': profileMahasiswa.pekerjaanAyah,
          'pekerjaan_ibu': profileMahasiswa.pekerjaanIbu,
        },
      );

      if (response.statusCode == 200) {
        // Profile mahasiswa berhasil diperbarui
        final data = json.decode(response.body);
        print('Profile mahasiswa berhasil diperbarui: $data');
        return true;
      } else {
        throw Exception('Gagal memperbarui profile mahasiswa');
      }
    } else {
      throw Exception('Token tidak tersedia');
    }
  }

  Future<ProfileMahasiswa?> getProfileDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('profile');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return ProfileMahasiswa.fromJson(data);
    } else {
      return null;
    }
  }


  //fungsi login

  //POST -- LOGIN
  Future<bool> loginData(BuildContext context, String id, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.getString(key) ?? '';

    final response = await http.post(
      Uri.parse('$BASE_URL$LOGIN'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value',
      },
      body: {
        "id": id,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final status = jsonResponse['status'];
      final message = jsonResponse['message'];

      if (status == "An error has occurred...") {
        // Login gagal, tampilkan pesan kesalahan
        print('Login failed: $message');
        return false;
      } else {
        // Login berhasil, simpan token dan lakukan navigasi ke halaman HomeScreen
        final token = jsonResponse['token'];
        prefs.setString(key, token);
        return true;
      }
    } else {
      // Terjadi kesalahan pada permintaan login, kembalikan false
      return false;
    }

  }
// Fungsi untuk menyimpan token ke SharedPreferences
  _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    await prefs.setString(key, token);
  }
// Fungsi untuk menampilkan dialog kesalahan request data
  _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<ProfileData?> getProfileData() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? '';

    String myUrl = "$BASE_URL$GET_USER_PROFILE";
    http.Response response = await http.get(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });

    if(response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return ProfileData.fromJson(data);
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  //INFO _ TERKINI
  // Fungsi Info Terkini
  Future<List> getDataInfoTerkini() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$BASE_URL$INFO_TERKINI";
    http.Response response = await http.get(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    return json.decode(response.body)['tbinfoterkini'];
  }

  void deleteDataInfoTerkini(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$BASE_URL/InfoTerkini/$id";
    http.delete(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        } ).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }


  void editDataInfoTerkini(int id,String judul , String isi) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

     String myUrl = "$BASE_URL/InfoTerkini/$id";
    http.put(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "judul": "$judul",
          "isi" : "$isi"
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }



// Fakultas dan Prodi

  //SERVER
  Fakultas? getFakultasFromNPM(String npm) {
    String fakultasKode = npm.substring(2, 4);

    for (Fakultas fakultas in listFakultas) {
      if (fakultas.kode == fakultasKode) {
        return fakultas;
      }
    }

    return null;
  }

  Prodi? getProdiFromNPM(String npm) {
    String prodiKode = npm.substring(2, 5);

    for (Prodi prodi in listProdi) {
      if (prodi.kode == prodiKode) {
        return prodi;
      }
    }

    return null;
  }

//LOCAL
  Future<Fakultas?> getFakultasDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('fakultas');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return Fakultas.fromJson(data);
    } else {
      return null;
    }
  }


  Future<Prodi?> getDataJurusanFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('jurusan');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return Prodi.fromJson(data);
    } else {
      return null;
    }
  }



// KRS
// Fungsi  untuk KRS -- Get from server

  // krs mahasiswa
  Future<Map<String, dynamic>> fetchKrsMahasiswa(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$KRS'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch KRS data');
    }
  }
//detail Krs
  Future<Map<String, dynamic>> fetchDetailKrsMahasiswa(String token, String idKrs) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$KRS/$idKrs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('$BASE_URL$KRS/$idKrs');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      print('$BASE_URL$KRS/$idKrs');


      return data;
    } else {
      throw Exception('Failed to fetch Detail KRS data');

    }


  }

  //isi Krs

  //GET


//fetch nilai uas from server

  Future<Map<String, dynamic>>fetchIsiKrsMahasiswa(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$ISI_KRS/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch nilai uas data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch nilai uas data. Error: $e');
    }
  }


  //krs diambil
  //GET
  Future<Map<String, dynamic>> fetchKrsDiambil(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$KRS_DIAMBIL/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Decoded Data: $data');
      print('$BASE_URL$ISI_KRS');

      return data;
    } else {
      throw Exception('Failed to fetch Isi KRS data');
    }
  }



  //POST

  Future<void> postIsiKrs(List<int> idJadwalList, String token) async {
    String url = '$BASE_URL$ISI_KRS';

    print(url);
    print(idJadwalList);
    print(token);

    // Buat request body berdasarkan parameter yang diberikan
    final requestBody = jsonEncode({
      "id_jadwal": idJadwalList,
    });

    print(requestBody);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept':'application/vnd.api+json',
          'Content-Type':'application/vnd.api+json',
          'Authorization': 'Bearer $token',

        },

        body: requestBody,
      );

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('POST request sukses!');
        print('Response: ${response.body}');
      }
      else if (response.statusCode == 201){
        print('POST request sukses!');
        print('Response: ${response.body}');
      } else if (response.statusCode == 422){
        print('KRS sudah diinput. terjadi duplikasi data!');
        print('Response: ${response.body}');
      }

      else{
        // Jika gagal, tangani kasus-kasus error
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan POST request: $e');
    }

  }
  
//fetch url untuk download krs
  Future<String> fetchUrlKrsMahasiswa(String token, String idKrs) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$KRS/$idKrs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('$BASE_URL$KRS/$idKrs');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      print('$BASE_URL$KRS/$idKrs');

      final fileUrl = data['file'] as String;
      return fileUrl;
    } else {
      throw Exception('Failed to fetch Detail KRS data');
    }
  }

  //DELETE - KRS Diambil

  Future<void> deleteKrsDiambil(String? idJadwal, String token) async {
    String url = '$BASE_URL$KRS/$idJadwal';
    print(url);

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.api+json',

        },
      );

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('DELETE request sukses!');
        print('Response: ${response.body}');
      } else if (response.statusCode == 204) {
        print('Data tidak ditemukan atau sudah dihapus sebelumnya.');
        print('Response: ${response.body}');
      } else {
        // Jika gagal, tangani kasus-kasus error
        print('DELETE request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan DELETE request: $e');
    }
  }


// Get krs From Preferences
  Future<Krs?> getKrsDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('krs');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return Krs.fromJson(data);
    } else {
      return null;
    }
  }

  //Get isiKrs From preferences

  Future<IsiKRSModel?> getIsiKrsDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('isiKrs');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return IsiKRSModel.fromJson(data);
    } else {
      return null;
    }
  }

//get krs diambil from preferences


  Future<KrsDiambilData?> getKrsDiambilDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('krsYangDiambil');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return KrsDiambilData.fromJson(data);
    } else {
      return null;
    }
  }


// Registrasi

//SERVER
  registerData(String name ,String id , String password) async{

    String myUrl = "$BASE_URL$REGISTRASI";
    final response = await  http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json'
        },
        body: {
          "name": "$name",
          "id": "$id",
          "password" : "$password"
        } ) ;
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if(status){
      print('data : ${data["error"]}');
    }else{
      print('data : ${data["token"]}');
      _save(data["token"]);
    }

  }

  Future<Map<String, dynamic>> fetchRegistrasiMahasiswa(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$REGISTRASI'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch Registrasi data');
    }
  }
//LOCAL
  Future<Registrasi?> getDataRegistrasiFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('registrasi');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return Registrasi.fromJson(data);
    } else {
      return null;
    }
  }



  //SuratPermohonan

  //SERVER
  //GET--SP
  Future<Map<String, dynamic>> fetchSuratPermohonan(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$SURATPERMOHONAN'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch Surat Permohonan');
    }
  }

  //LOCAL
  Future<SuratPermohonan?> getSuratPermohonanDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('surat_permohonan');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return SuratPermohonan.fromJson(data);
    } else {
      return null;
    }
  }

  //Notifikasi

//SERVER
  Future<Map<String, dynamic>> fetchNotifikasiSiak(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$PENGUMUMAN'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //LOCAL

//get from preferences
  Future<SiakNotifikasiModel?> getNotifDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('pengumuman');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return SiakNotifikasiModel.fromJson(data);
    } else {
      return null;
    }
  }

  // Transkrip

//SERVER


  Future<Map<String, dynamic>> fetchTranskrip(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$TRANSKRIPNILAI'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch transkripnilai data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch transkripnilai data. Error: $e');
    }
  }

  // LOCAL
  Future<SiakNotifikasiModel?> getTranskripNilaiDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('transkripNilai');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return SiakNotifikasiModel.fromJson(data);
    } else {
      return null;
    }
  }

  //KHS

//SERVER

  //fetchDownload KHS detail
  Future<Map<String, dynamic>> fetchDownloadKhsMahasiswa(String token, String idKhs) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$DOWNLOAD_KHS/$idKhs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('$BASE_URL$GET_KHS/$idKhs');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      print('$BASE_URL$GET_KHS/$idKhs');


      return data;
    } else {
      throw Exception('Failed to fetch Detail KHS data');

    }


  }

  // Get-Khs from server
  //fetch Khs
  Future<Map<String, dynamic>> fetchKhs(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$GET_KHS'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  // LOCAL
  Future<KhsModel?> getKhsDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('khs');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return KhsModel.fromJson(data);
    } else {
      return null;
    }
  }


  //DETAIL KHS
//SERVER
  //get detail khs

  Future<Map<String, dynamic>> fetchDetailKhs(String token, String idKhs) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$GET_KHS/$idKhs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //fetch KHS detail
  Future<Map<String, dynamic>> fetchDetailKhsMahasiswa(String token, String idKhs) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$GET_KHS/$idKhs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('$BASE_URL$GET_KHS/$idKhs');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      print('$BASE_URL$GET_KHS/$idKhs');


      return data;
    } else {
      throw Exception('Failed to fetch Detail KHS data');

    }


  }



  //NILAI

//feth nilai UTS from server



  Future<Map<String, dynamic>> fetchNilaiUts(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$NILAI_UTS'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch nilai uts data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch nilai uts data. Error: $e');
    }
  }

  // LOCAL
  Future<NilaiUTSModel?> getNilaiUtsDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('uts');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return NilaiUTSModel.fromJson(data);
    } else {
      return null;
    }
  }

//fetch nilai uas from server

  Future<Map<String, dynamic>> fetchNilaiUAS(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$NILAI_UAS'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch nilai uas data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch nilai uas data. Error: $e');
    }
  }

  Future<NilaiUASModel?> getNilaiUasDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('uas');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return NilaiUASModel.fromJson(data);
    } else {
      return null;
    }
  }


  //SURAT PERMOHONAN

//POST

//Surat Aktif
  Future<void> postSuratAktif(String nama_ortu, String keperluan, String token) async {
    String url = '$BASE_URL$ISI_SURAT_AKTIF';
    print(url);
    print(token);

    print(nama_ortu);
    print(keperluan);


    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "nmortu": nama_ortu,
          "keperluan": keperluan,
        },
      );

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('POST request sukses!');
        print('Response: ${response.body}');
      }


      else{
        // Jika gagal, tangani kasus-kasus error
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan POST request: $e');
    }

  }

  // GET - Surat Aktif
  Future<Map<String, dynamic>> fetchSuratAktifPreview(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$SURAT_AKTIF/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('$BASE_URL$SURAT_AKTIF/');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch preview surat aktif. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch surat aktif. Error: $e');
    }
  }



  // GET - Surat Aktif
  Future<Map<String, dynamic>> fetchSuratRiset(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$SURAT_RISET/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('$BASE_URL$SURAT_RISET/');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch preview surat riset. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch surat riset. Error: $e');
    }
  }

//Post surat riset to server
  Future<void> postSuratRiset(String judulTA, String tempatPenelitian, String alamatPenelitian, String token) async {
    String url = '$BASE_URL$ISI_SURAT_RISET';
    print(url);
    print(token);
    print(judulTA);
    print(tempatPenelitian);
    print(alamatPenelitian);



    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "judul": judulTA,
          "tempat_penelitian": tempatPenelitian,
          "alamat_peneliatian" : alamatPenelitian,
        },
      );

      // Cek status code dari response
      if (response.statusCode == 200) {

        print('POST request sukses!');
        print('Response: ${response.body}');
      }


      else{
        // Jika gagal, tangani kasus-kasus error
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan POST request: $e');
    }

  }

  //POST - Isi Angket


  //POST

  Future<void> postIsiAngket(List<int> jawaban, String kodeMatkul, String token) async {
    String url = '$BASE_URL$ISI_ANGKET$kodeMatkul';

    print(url);
    print(kodeMatkul);
    print(token);

    // Buat request body berdasarkan parameter yang diberikan
    final requestBody = jsonEncode({
      "jawaban": jawaban,
    });

    print(requestBody);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {

          'Accept':'application/vnd.api+json',
          'Content-Type':'application/vnd.api+json',
          'Authorization': 'Bearer $token',

        },

        body: requestBody,
      );

      // Cek status code dari response
      if (response.statusCode == 201) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('POST request sukses!');
        print('Response: ${response.body}');
      }
      else if (response.statusCode == 200){
        print('POST request sukses!');
        print('Response: ${response.body}');
      } else if (response.statusCode == 422){
        print('Angket sudah diinput. terjadi duplikasi data!');
        print('Response: ${response.body}');
      }

      else{
        // Jika gagal, tangani kasus-kasus error
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan POST request: $e');
    }

  }

  // komplain mata kuliah

  //GET-DaftarUangKuliah

//GET
  Future<Map<String, dynamic>> fetchDaftarUangKuliah(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$UANG_KULIAH/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Decoded Data: $data');
      print('$BASE_URL$UANG_KULIAH/');

      return data;
    } else {
      throw Exception('Failed to fetch Daftar Uang Kuliah');
    }
  }




  //GET-Kuitansi Telah Dibayar

//GET
  Future<Map<String, dynamic>> fetchKuitansiTelahDibayar(String token) async {
    final response = await http.get(
      Uri.parse('$BASE_URL$UANG_KULIAH_DIBAYAR/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Decoded Data: $data');
      print('$BASE_URL$UANG_KULIAH_DIBAYAR');

      return data;
    } else {
      throw Exception('Failed to fetch Kuitansi data');
    }
  }


//POST

//Surat Aktif
  Future<void> postComplain(String alasan, String? idJadwal , String token) async {
    String url = '$BASE_URL$COMPLAIN$idJadwal';
    print(url);
    print(token);

    print(alasan);
    print(idJadwal);


    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "alasan": alasan,

        },
      );

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('POST request sukses!');
        print('Response: ${response.body}');
      }


      else{
        // Jika gagal, tangani kasus-kasus error
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan POST request: $e');
    }

  }


  //get complain - mata kuliah and id jadwal from preferences


  Future<NilaiUasElement?> getNilaiUasElementDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('uas');

    if (jsonData != null && jsonData.isNotEmpty) {
      final data = jsonDecode(jsonData);
      return NilaiUasElement.fromJson(data);
    } else {
      return null;
    }
  }


  //absensi
//fetch absensi from server


  Future<Map<String, dynamic>> fetchDataMataKuliahAbsensi(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$ABSENSI'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch nilai absensi mata kuliah data. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch absensi mata kuliah data. Error: $e');
    }
  }


  Future<Map<String, dynamic>> fetchDataRincianAbsensi(String token, String idJadwal) async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL$RINCIAN_ABSENSI$idJadwal'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch rincian absensi mata kuliah. HTTP Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch rincian absensi. Error: $e');
    }
  }

  //POST - Isi absen mahasiswa

  Future<void> postIsiAbsen(String status, String token, String idJadwal) async {
    String url = '$BASE_URL$ABSEN_MAHASISWA$idJadwal';
    print(url);
    print(token);
    print(idJadwal);
    print(status);


    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept':'application/vnd.api+json',
        },
        body: {
          "status": status,
        },
      );

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('POST request sukses!');
        print('Response: ${response.body}');
      }
      else if (response.statusCode == 400) {
        // Jika sukses, lakukan tindakan sesuai kebutuhan (misalnya, memproses data response)
        print('Absensi Sudah Diinput Sebelumnya!');
        print('Response: ${response.body}');
      }


      else{
        // Jika gagal, tangani kasus-kasus error
        print('POST request gagal dengan status code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jika ada masalah dalam melakukan request
      print('Error saat melakukan POST request: $e');
    }

  }

}

