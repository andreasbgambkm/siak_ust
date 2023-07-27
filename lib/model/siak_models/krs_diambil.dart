class KrsDiambilModel {
  UserKrsDiambil user;
  List<KrsDiambilData> krsDiambil;
  bool status;

  KrsDiambilModel({
    required this.user,
    required this.krsDiambil,
    required this.status,
  });

  factory KrsDiambilModel.fromJson(Map<String, dynamic> json) {
    return KrsDiambilModel(
      user: UserKrsDiambil.fromJson(json['user']),
      krsDiambil: List<KrsDiambilData>.from(
        json['krs_diambil'].map((data) => KrsDiambilData.fromJson(data)),
      ),
      status: json['status'],
    );
  }
}

class UserKrsDiambil {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  int semesterBerjalan;
  String ipSemesterSebelum;
  int maksSks;

  UserKrsDiambil({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.semesterBerjalan,
    required this.ipSemesterSebelum,
    required this.maksSks,
  });

  factory UserKrsDiambil.fromJson(Map<String, dynamic> json) {
    return UserKrsDiambil(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      semesterBerjalan: json['semester_berjalan'],
      ipSemesterSebelum: json['ipsemestersebelum'],
      maksSks: json['maks_SKS'],
    );
  }
}

class KrsDiambilData {
  Jadwal jadwal;
  String statusKrs;

  KrsDiambilData({
    required this.jadwal,
    required this.statusKrs,
  });

  factory KrsDiambilData.fromJson(Map<String, dynamic> json) {
    return KrsDiambilData(
      jadwal: Jadwal.fromJson(json['jadwal']),
      statusKrs: json['statuskrs'],
    );
  }
}

class Jadwal {
  int id;
  String kdMatkul;
  String hari;
  String kdJam;
  String dosen;
  String kelas;
  String nmMatkul;
  String semester;
  String sks;

  Jadwal({
    required this.id,
    required this.kdMatkul,
    required this.hari,
    required this.kdJam,
    required this.dosen,
    required this.kelas,
    required this.nmMatkul,
    required this.semester,
    required this.sks,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      kdMatkul: json['kd_matkul'],
      hari: json['hari'],
      kdJam: json['kd_jam'],
      dosen: json['dosen'],
      kelas: json['kelas'],
      nmMatkul: json['nm_matkul'],
      semester: json['semester'],
      sks: json['sks'],
    );
  }
}
