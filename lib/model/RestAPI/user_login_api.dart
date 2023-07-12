
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/constants/constants.dart';
import 'package:siak/model/data/mahasiswa/mahasiswa.dart';
import 'package:siak/model/siak_models/mahasiswa_model.dart';

class DatabaseHelper{

  var status ;

  var token ;



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


  loginData(BuildContext context, String id, String password) async {
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

    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.containsKey('token')) {
        String newToken = data['token'];
        await _saveToken(newToken);
        print('Token baru: $newToken');
        // Lakukan navigasi ke halaman HomeScreen
        Navigator.pushReplacementNamed(context, '/home_screen');
      } else {
        // Tangani kesalahan jika tidak ada token dalam response
        print('Response tidak berisi token');
        _showAlertDialog(context, 'Login failed. Please try again.');
      }
    } else {
      // Tangani kesalahan ketika permintaan HTTP gagal
      print('HTTP request failed with status: ${response.statusCode}');
      _showAlertDialog(context, 'Login failed. Please try again.');
    }
  }

// Fungsi untuk menyimpan token ke SharedPreferences
  _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    await prefs.setString(key, token);
  }

// Fungsi untuk menampilkan dialog kesalahan
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



  registerData(String name ,String id , String password) async{

    String myUrl = "$BASE_URL$REGISTER";
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

  Future<List> getData() async{

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

  void deleteData(int id) async {
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

  void addData(String name , String price) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$BASE_URL";
    http.post(Uri.parse(myUrl),
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        },
        body: {
          "name": "$name",
          "price" : "$price"
        }).then((response){
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


}

