// To parse this JSON data, do
//
//     final mahasiswa = mahasiswaFromJson(jsonString);

import 'dart:convert';

import 'package:siak/model/siak_models/mahasiswa_model.dart';

List<JenisSurat> mahasiswaFromJson(String str) => List<JenisSurat>.from(json.decode(str).map((x) => JenisSurat.fromJson(x)));

String mahasiswaToJson(List<JenisSurat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JenisSurat extends ProfileMahasiswa {
  JenisSurat({
    required this.idSurat,
   required this.jenisSurat,
  });

  String idSurat;
  String jenisSurat;

  factory JenisSurat.fromJson(Map<String, dynamic> json) => JenisSurat(
    idSurat: json["ID_Surat"],
    jenisSurat: json["Jenis_Surat"],
  );

  Map<String, dynamic> toJson() => {
    "ID_Surat": idSurat,
    "Jenis_Surat": jenisSurat,
  };
}
