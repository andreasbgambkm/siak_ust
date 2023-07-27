class IsiKRSModel {
  UserIsiKRS user;
  List<JadwalKRS> krs;

  IsiKRSModel({
    required this.user,
    required this.krs,
  });

  factory IsiKRSModel.fromJson(Map<String, dynamic> json) {
    return IsiKRSModel(
      user: UserIsiKRS.fromJson(json['user']),
      krs: List<JadwalKRS>.from(json['krs'].map((item) => JadwalKRS.fromJson(item))),
    );
  }
}

class JadwalKRS {
  int id;
  String kdMatkul;
  String hari;
  String kdJam;
  String dosen;
  String kelas;
  String nmMatkul;
  String semester;
  int sks;
  int sudahDiambil;

  JadwalKRS({
    required this.id,
    required this.kdMatkul,
    required this.hari,
    required this.kdJam,
    required this.dosen,
    required this.kelas,
    required this.nmMatkul,
    required this.semester,
    required this.sks,
    required this.sudahDiambil,
  });

  factory JadwalKRS.fromJson(Map<String, dynamic> json) {
    return JadwalKRS(
      id: json['id'],
      kdMatkul: json['kd_matkul'],
      hari: json['hari'],
      kdJam: json['kd_jam'],
      dosen: json['dosen'],
      kelas: json['kelas'],
      nmMatkul: json['nm_matkul'],
      semester: json['semester'],
      sks: int.parse(json['sks']),
      sudahDiambil: int.parse(json['sudah_diambil']),
    );
  }
}

class UserIsiKRS {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  int semesterBerjalan;
  double ipSemesterSebelum;
  int maksSks;

  UserIsiKRS({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.semesterBerjalan,
    required this.ipSemesterSebelum,
    required this.maksSks,
  });

  factory UserIsiKRS.fromJson(Map<String, dynamic> json) {
    return UserIsiKRS(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      semesterBerjalan: json['semester_berjalan'],
      ipSemesterSebelum: double.parse(json['ipsemestersebelum']),
      maksSks: json['maks_SKS'],
    );
  }
}
