class TranskripModel {
  UserTranskrip user;
  List<TranskripNilai> transkripNilai;

  TranskripModel({
    required this.user,
    required this.transkripNilai,
  });

  factory TranskripModel.fromJson(Map<String, dynamic> json) {
    return TranskripModel(
      user: UserTranskrip.fromJson(json['user']),
      transkripNilai: json['transkrip_nilai'] != null
          ? List<TranskripNilai>.from(
          json['transkrip_nilai'].map((x) => TranskripNilai.fromJson(x)))
          : [],
    );
  }
}

class UserTranskrip {
  int? npm;
  String? nama;
  String? prodi;
  String? fakultas;
  String? ipk;
  String? totalSks;

  UserTranskrip({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.ipk,
    required this.totalSks,
  });

  factory UserTranskrip.fromJson(Map<String, dynamic> json) {
    return UserTranskrip(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      ipk: json['ipk'],
      totalSks: json['totalsks'],
    );
  }
}

class TranskripNilai {
  String kdMatkul;
  String nmMatkul;
  String sks;
  String kelas;
  String semester;
  String nAngka;
  String nilaiHuruf;

  TranskripNilai({
    required this.kdMatkul,
    required this.nmMatkul,
    required this.sks,
    required this.kelas,
    required this.semester,
    required this.nAngka,
    required this.nilaiHuruf,
  });

  factory TranskripNilai.fromJson(Map<String, dynamic> json) {
    return TranskripNilai(
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
