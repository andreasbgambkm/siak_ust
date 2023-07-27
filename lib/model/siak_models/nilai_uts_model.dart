class NilaiUTSModel {
  UserUts user;
  List<NilaiElement> nilai;

  NilaiUTSModel({
    required this.user,
    required this.nilai,
  });

  factory NilaiUTSModel.fromJson(Map<String, dynamic> json) {
    return NilaiUTSModel(
      user: UserUts.fromJson(json['user']),
      nilai: json['nilai'] != null
          ? List<NilaiElement>.from(json['nilai'].map((x) => NilaiElement.fromJson(x)))
          : [],
    );
  }
}

class NilaiElement {
  String kdMatkul;
  String nmMatkul;
  String sks;
  String nUTS;

  NilaiElement({
    required this.kdMatkul,
    required this.nmMatkul,
    required this.sks,
    required this.nUTS,
  });

  factory NilaiElement.fromJson(Map<String, dynamic> json) {
    return NilaiElement(
      kdMatkul: json['kd_matkul'],
      nmMatkul: json['nm_matkul'],
      sks: json['sks'],
      nUTS: json['n_uts'],
    );
  }
}

class UserUts {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  int semester;
  String tahunAjaran;

  UserUts({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.semester,
    required this.tahunAjaran,
  });

  factory UserUts.fromJson(Map<String, dynamic> json) {
    return UserUts(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      semester: json['semester'],
      tahunAjaran: json['tahun_ajaran'],
    );
  }
}
