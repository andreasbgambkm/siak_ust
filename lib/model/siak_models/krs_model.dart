// To parse this JSON data, do
//
//     final krs = krsFromJson(jsonString);

import 'dart:convert';

import 'package:siak/model/siak_models/mahasiswa_model.dart';

List<Krs> krsFromJson(String str) => List<Krs>.from(json.decode(str).map((x) => Krs.fromJson(x)));

String krsToJson(List<Krs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Krs extends ProfileMahasiswa{
  Krs({
    required this.thnAjaran,
    required this.idKrs,

    required this.ips,
  });

  String thnAjaran;
  String idKrs;

  String ips;

  factory Krs.fromJson(Map<String, dynamic> json) => Krs(
    thnAjaran: json["thn_ajaran"],
    idKrs: json["id_krs"],

    ips: json["ips"],
  );

  Map<String, dynamic> toJson() => {
    "thn_ajaran": thnAjaran,
    "id_krs": idKrs,
    "npm": npm,
    "ips": ips,
  };
}
