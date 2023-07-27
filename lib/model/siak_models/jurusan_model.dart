import 'dart:convert';

class Prodi {
  String? kode;
  String? nama;

  Prodi({required this.kode, required this.nama});

  factory Prodi.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Prodi(
      kode: data['kode'],
      nama: data['nama'],
    );
  }
}
