import 'package:siak/model/siak_models/mahasiswa_model.dart';

class SiakDetailKHSModel extends ProfileMahasiswa {
  UserSiakDetailKHS user;
  List<KhsDetail> khs;

  SiakDetailKHSModel({required this.user, required this.khs});

  factory SiakDetailKHSModel.fromJson(Map<String, dynamic> json) {
    return SiakDetailKHSModel(
      user: UserSiakDetailKHS.fromJson(json['user']),
      khs: json['khs'] != null
          ? List<KhsDetail>.from(json['khs'].map((x) => KhsDetail.fromJson(x)))
          : [],
    );
  }
}

class UserSiakDetailKHS {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  String ip;
  String totalSks;

  UserSiakDetailKHS({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.ip,
    required this.totalSks,
  });

  factory UserSiakDetailKHS.fromJson(Map<String, dynamic> json) {
    return UserSiakDetailKHS(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      ip: json['ip'],
      totalSks: json['totalsks'],
    );
  }
}

class KhsDetail {
  String kdMatkul;
  String nmMatkul;
  String sks;
  String kelas;
  String semester;
  String nAngka;
  String nilaiHuruf;

  KhsDetail({
    required this.kdMatkul,
    required this.nmMatkul,
    required this.sks,
    required this.kelas,
    required this.semester,
    required this.nAngka,
    required this.nilaiHuruf,
  });

  factory KhsDetail.fromJson(Map<String, dynamic> json) {
    return KhsDetail(
      kdMatkul: json['kd_matkul'],
      nmMatkul: json['nm_matkul'],
      sks: json['sks'],
      kelas: json['kelas'],
      semester: json['semester'],
      nAngka: json['N_angka'],
      nilaiHuruf: json['nilai_huruf'],
    );
  }
}
