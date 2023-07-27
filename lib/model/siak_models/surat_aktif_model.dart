import 'package:siak/model/siak_models/mahasiswa_model.dart';

class SuratAktif extends ProfileMahasiswa {
  UserSuratAktif user;
  List<SuratAktifItem> suratAktifList;

  SuratAktif({required this.user, required this.suratAktifList});

  factory SuratAktif.fromJson(Map<String, dynamic> json) {
    return SuratAktif(
      user: UserSuratAktif.fromJson(json['user']),
      suratAktifList: json['surat_aktif'] != null
          ? List<SuratAktifItem>.from(json['surat_aktif'].map((x) => SuratAktifItem.fromJson(x)))
          : [],
    );
  }
}

class UserSuratAktif {
  int? npm;
  String? nama;
  String? fakultas;
  String? prodi;

  UserSuratAktif({
    required this.npm,
    required this.nama,
    required this.fakultas,
    required this.prodi,
  });

  factory UserSuratAktif.fromJson(Map<String, dynamic> json) {
    return UserSuratAktif(
      npm: json['npm'],
      nama: json['nama'],
      fakultas: json['fakultas'],
      prodi: json['prodi'],
    );
  }
}

class SuratAktifItem {
  int? npm;
  String? tanggal;
  String? keperluan;
  String? ta;
  String? nmortu;

  SuratAktifItem({
    required this.npm,
    required this.tanggal,
    required this.keperluan,
    required this.ta,
    required this.nmortu,
  });

  factory SuratAktifItem.fromJson(Map<String, dynamic> json) {
    return SuratAktifItem(
      npm: json['NPM'],
      tanggal: json['Tanggal'],
      keperluan: json['keperluan'],
      ta: json['ta'],
      nmortu: json['nmortu'],
    );
  }
}
