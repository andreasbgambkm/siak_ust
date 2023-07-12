// To parse this JSON data, do
//
//     final detailKrs = detailKrsFromJson(jsonString);

import 'dart:convert';

import 'package:siak/model/siak_models/mahasiswa_model.dart';

List<DetailKrs> detailKrsFromJson(String str) => List<DetailKrs>.from(json.decode(str).map((x) => DetailKrs.fromJson(x)));

String detailKrsToJson(List<DetailKrs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailKrs  extends ProfileMahasiswa{
  DetailKrs({
    required this.idKrs,
    required this.idJadwal,
    required this.nSk,
    required this.nTugas,
    required this.nUts,
    required this.nUas,
    required this.nPrak,
    required this.nAngka,
    required this.statusAngket,
    required this.kelas,
    required this.statusNilai,
    required this.statusTranskrip,}
  ) ;

  String idKrs;
  String idJadwal;
  String nSk;
  String nTugas;
  String nUts;
  String nUas;
  String nPrak;
  String nAngka;
  String statusAngket;
  String kelas;
  String statusNilai;
  String statusTranskrip;

  factory DetailKrs.fromJson(Map<String, dynamic> json) => DetailKrs(
    idKrs: json["id_krs"],
    idJadwal: json["id_jadwal"],
    nSk: json["n_sk"],
    nTugas: json["n_tugas"],
    nUts: json["n_uts"],
    nUas: json["n_uas"],
    nPrak: json["n_prak"],
    nAngka: json["N_angka"],
    statusAngket: json["status_angket"],
    kelas: json["kelas"],
    statusNilai: json["status_nilai"],
    statusTranskrip: json["status_transkrip"],
  );

  Map<String, dynamic> toJson() => {
    "id_krs": idKrs,
    "id_jadwal": idJadwal,
    "n_sk": nSk,
    "n_tugas": nTugas,
    "n_uts": nUts,
    "n_uas": nUas,
    "n_prak": nPrak,
    "N_angka": nAngka,
    "status_angket": statusAngket,
    "kelas": kelas,
    "status_nilai": statusNilai,
    "status_transkrip": statusTranskrip,
  };
}
