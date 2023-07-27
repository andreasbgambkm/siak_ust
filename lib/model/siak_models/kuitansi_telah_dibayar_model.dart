class KuitansiTelahDibayar {
  UserKuitansiTelahDibayar user;
  List<UangKuliahDibayar> uangKuliahDibayar;

  KuitansiTelahDibayar({required this.user, required this.uangKuliahDibayar});

  factory KuitansiTelahDibayar.fromJson(Map<String, dynamic> json) {
    return KuitansiTelahDibayar(
      user: UserKuitansiTelahDibayar.fromJson(json['user']),
      uangKuliahDibayar: json['uang_kuliah_dibayar'] != null
          ? List<UangKuliahDibayar>.from(json['uang_kuliah_dibayar'].map((x) => UangKuliahDibayar.fromJson(x)))
          : [],
    );
  }
}

class UserKuitansiTelahDibayar {
  int npm;
  String nama;
  String prodi;
  String fakultas;

  UserKuitansiTelahDibayar({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
  });

  factory UserKuitansiTelahDibayar.fromJson(Map<String, dynamic> json) {
    return UserKuitansiTelahDibayar(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
    );
  }
}

class UangKuliahDibayar {
  String noVa;
  String namaJenisBayar;
  String ta;
  String jlhBayar;
  String status;

  UangKuliahDibayar({
    required this.noVa,
    required this.namaJenisBayar,
    required this.ta,
    required this.jlhBayar,
    required this.status,
  });

  factory UangKuliahDibayar.fromJson(Map<String, dynamic> json) {
    return UangKuliahDibayar(
      noVa: json['no_va'],
      namaJenisBayar: json['nama_jenis_bayar'],
      ta: json['ta'],
      jlhBayar: json['jlh_bayar'],
      status: json['status'],
    );
  }
}
