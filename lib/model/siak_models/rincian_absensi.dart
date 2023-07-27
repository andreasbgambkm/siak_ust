class RincianAbsensi {
  UserRincianAbsensi user;
  List<AbsensiPertemuan> absensi_pertemuan;

  RincianAbsensi({
    required this.user,
    required this.absensi_pertemuan,
  });

  factory RincianAbsensi.fromJson(Map<String, dynamic> json) {
    return RincianAbsensi(
      user: UserRincianAbsensi.fromJson(json['user']),
      absensi_pertemuan: List<AbsensiPertemuan>.from(json['absensi'].map((x) => AbsensiPertemuan.fromJson(x))),
    );
  }
}

class UserRincianAbsensi {
  int npm;
  String nama;
  String prodi;
  String fakultas;
  int semester;
  String tahunAjaran;
  String kodeMatakuliah;
  String namaMatakuliah;

  UserRincianAbsensi({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
    required this.semester,
    required this.tahunAjaran,
    required this.kodeMatakuliah,
    required this.namaMatakuliah,
  });

  factory UserRincianAbsensi.fromJson(Map<String, dynamic> json) {
    return UserRincianAbsensi(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
      semester: json['semester'],
      tahunAjaran: json['tahun_ajaran'],
      kodeMatakuliah: json['kode_matakuliah'],
      namaMatakuliah: json['nama_matakuliah'],
    );
  }
}

class AbsensiPertemuan {
  String tgl;
  String hari;
  String ruangan;
  String status;
  String topik;
  String subtopik;
  String pertemuan;
  String absenButton;

  AbsensiPertemuan({
    required this.tgl,
    required this.hari,
    required this.ruangan,
    required this.status,
    required this.topik,
    required this.absenButton,
    required this.pertemuan,
    required this.subtopik,
  });

  factory AbsensiPertemuan.fromJson(Map<String, dynamic> json) {
    return AbsensiPertemuan(
      tgl: json['tgl'],
      hari: json['hari'],
      ruangan: json['ruangan'],
      status: json['status'],
      topik: json['topik'],
      absenButton: json['absenButton'],
      pertemuan: json['pertemuan'],
      subtopik: json['subtopik'],
    );
  }
}
