class User {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  int semester;
  String tahunAjaran;

  User({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.semester,
    required this.tahunAjaran,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      semester: json['semester'],
      tahunAjaran: json['tahun_ajaran'],
    );
  }
}

class MataKuliah {
  String idJadwal;
  String kdMatkul;
  String nmMatkul;
  Absensi absensi;

  MataKuliah({
    required this.idJadwal,
    required this.kdMatkul,
    required this.nmMatkul,
    required this.absensi,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      idJadwal: json['id_jadwal'],
      kdMatkul: json['kd_matkul'],
      nmMatkul: json['nm_matkul'],
      absensi: Absensi.fromJson(json['absensi']),
    );
  }
}

class Absensi {
  int alpha;
  int ijin;
  int sakit;
  int hadir;
  String presentase;

  Absensi({
    required this.alpha,
    required this.ijin,
    required this.sakit,
    required this.hadir,
    required this.presentase,
  });

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      alpha: json['alpha'],
      ijin: json['ijin'],
      sakit: json['sakit'],
      hadir: json['hadir'],
      presentase: json['presentase'],
    );
  }
}

class AbsensiMataKuliah {
  User user;
  List<MataKuliah> matakuliah;

  AbsensiMataKuliah({
    required this.user,
    required this.matakuliah,
  });

  factory AbsensiMataKuliah.fromJson(Map<String, dynamic> json) {
    return AbsensiMataKuliah(
      user: User.fromJson(json['user']),
      matakuliah: List<MataKuliah>.from(json['matakuliah'].map((x) => MataKuliah.fromJson(x))),
    );
  }
}
