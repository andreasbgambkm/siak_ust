import 'package:siak/model/siak_models/mahasiswa_model.dart';

class Krs extends ProfileMahasiswa {
  UserKrs user;
  List<Combobox> combobox;

  Krs({required this.user, required this.combobox});

  factory Krs.fromJson(Map<String?, dynamic> json) {
    return Krs(
      user: UserKrs.fromJson(json['user']),
      combobox: json['combobox'] != null
          ? List<Combobox>.from(json['combobox'].map((x) => Combobox.fromJson(x)))
          : [],

    );
  }
}

class UserKrs {
  int? npm;
  String? nama;
  String? prodi;
  int? semesterBerjalan;
  String? ipSemesterSebelum;
  int? maksSks;

  UserKrs({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.semesterBerjalan,
    required this.ipSemesterSebelum,
    required this.maksSks,
  });

  factory UserKrs.fromJson(Map<String, dynamic> json) {
    return UserKrs(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      semesterBerjalan: json['semester_berjalan'],
      ipSemesterSebelum: json['ipsemestersebelum'],
      maksSks: json['maks_SKS'],
    );
  }
}

class Combobox {
  String id;
  String tahunAjaran;
  String semester;

  Combobox({required this.id, required this.tahunAjaran, required this.semester});

  factory Combobox.fromJson(Map<String, dynamic> json) {
    return Combobox(
      id: json['id'],
      tahunAjaran: json['tahun_ajaran'],
      semester: json['semester'],
    );
  }
}
