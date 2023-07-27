class DaftarUangKuliahModel {
  UserDaftarUangKuliah user;
  List<UangKuliahItem> listUangKuliah;

  DaftarUangKuliahModel({
    required this.user,
    required this.listUangKuliah,
  });

  factory DaftarUangKuliahModel.fromJson(Map<String, dynamic> json) {
    return DaftarUangKuliahModel(
      user: UserDaftarUangKuliah.fromJson(json['user']),
      listUangKuliah: List<UangKuliahItem>.from(
        json['list_uang_kuliah'].map((item) => UangKuliahItem.fromJson(item)),
      ),
    );
  }
}

class UserDaftarUangKuliah {
  int npm;
  String nama;
  String prodi;
  String fakultas;

  UserDaftarUangKuliah({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
  });

  factory UserDaftarUangKuliah.fromJson(Map<String, dynamic> json) {
    return UserDaftarUangKuliah(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
    );
  }
}

class UangKuliahItem {
  String kdkwitansi;
  String noVa;
  String namaJenisBayar;
  String mulai;
  String batas;

  UangKuliahItem({
    required this.kdkwitansi,
    required this.noVa,
    required this.namaJenisBayar,
    required this.mulai,
    required this.batas,
  });

  factory UangKuliahItem.fromJson(Map<String, dynamic> json) {
    return UangKuliahItem(
      kdkwitansi: json['kdkwitansi'],
      noVa: json['no_va'],
      namaJenisBayar: json['nama_jenis_bayar'],
      mulai: json['mulai'],
      batas: json['batas'],
    );
  }
}
