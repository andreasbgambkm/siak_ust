import 'package:siak/model/siak_models/mahasiswa_model.dart';

class Registrasi extends ProfileMahasiswa{
  UserRegistrasi userreg;
  List<RegistrasiElement> registrasi_element;

  Registrasi({
    required this.userreg,
    required this.registrasi_element,
  });

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      userreg: UserRegistrasi.fromJson(json['user']),
      registrasi_element: json['registrasi'] != null ? List<RegistrasiElement>.from(json['registrasi'].map((x) => RegistrasiElement.fromJson(x))) :[],

    );
  }

}

class RegistrasiElement {
  String tglRegistrasi;
  String thnAjaran;
  int npm;
  String status;
  String noDaftar;

  RegistrasiElement({
    required this.tglRegistrasi,
    required this.thnAjaran,
    required this.npm,
    required this.status,
    required this.noDaftar,
  });


  factory RegistrasiElement.fromJson(Map<String, dynamic> json) {
    return RegistrasiElement(
        tglRegistrasi: json['tgl_registrasi'],
        thnAjaran: json['thn_ajaran'],
        npm: json['npm'],
        status: json['status'],
        noDaftar: json['No_daftar'],


    );
  }


}

class UserRegistrasi {
  String prodi;
  String fakultas;

  UserRegistrasi({
    required this.prodi,
    required this.fakultas,
  });

  factory UserRegistrasi.fromJson(Map<String, dynamic> json) {
    return UserRegistrasi(
        prodi: json['prodi'],
        fakultas: json['fakultas']

    );
  }

}
