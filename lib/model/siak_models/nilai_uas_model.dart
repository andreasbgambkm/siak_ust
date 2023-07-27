class NilaiUASModel {
  UserUas user;
  List<NilaiUasElement> nilai;

  NilaiUASModel({
    required this.user,
    required this.nilai,
  });

  factory NilaiUASModel.fromJson(Map<String, dynamic> json) {
    return NilaiUASModel(
      user: UserUas.fromJson(json['user']),
      nilai: json['nilai'] != null
          ? List<NilaiUasElement>.from(json['nilai'].map((x) => NilaiUasElement.fromJson(x)))
          : [],
    );
  }
}

class NilaiUasElement {
  String id;
  String kdMatkul;
  String nmMatkul;
  String sks;
  String nUTS;
  String nSK;
  String nTugas;
  String nUAS;
  String nAngka;
  String statusAngket;
  String nilaiHuruf;

  NilaiUasElement({
    required this.id,
    required this.kdMatkul,
    required this.nmMatkul,
    required this.sks,
    required this.nUTS,
    required this.nSK,
    required this.nTugas,
    required this.nUAS,
    required this.nAngka,
    required this.statusAngket,
    required this.nilaiHuruf,
  });

  factory NilaiUasElement.fromJson(Map<String, dynamic> json) {
    return NilaiUasElement(
      id: json['id'],
      kdMatkul: json['kd_matkul'],
      nmMatkul: json['nm_matkul'],
      sks: json['sks'],
      nUTS: json['n_uts'],
      nSK: json['n_sk'],
      nTugas: json['n_tugas'],
      nUAS: json['n_uas'],
      nAngka: json['N_angka'],
      statusAngket: json['status_angket'],
      nilaiHuruf: json['nilai_huruf'],
    );
  }
}

class UserUas {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  int semester;
  String tahunAjaran;

  UserUas({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.semester,
    required this.tahunAjaran,
  });

  factory UserUas.fromJson(Map<String, dynamic> json) {
    return UserUas(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      semester: json['semester'],
      tahunAjaran: json['tahun_ajaran'],
    );
  }
}
