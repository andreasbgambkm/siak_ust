import 'dart:convert';

class Fakultas {
  String? kode;
  String? nama;

  Fakultas({required this.kode, required this.nama});

  factory Fakultas.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Fakultas(
      kode: data['kode'],
      nama: data['nama'],
    );
  }
}
