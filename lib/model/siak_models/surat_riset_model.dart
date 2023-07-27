class SuratRisetModel {
  final USERRiset user;

  SuratRisetModel({required this.user});

  factory SuratRisetModel.fromJson(Map<String, dynamic> json) {
    return SuratRisetModel(
      user: USERRiset.fromJson(json['user']),
    );
  }
}

class USERRiset {
  final int npm;
  final String nama;
  final String fakultas;
  final String prodi;
  final String judul;
  final String tempatPenelitian;
  final String alamatPenelitian;

  USERRiset({
    required this.npm,
    required this.nama,
    required this.fakultas,
    required this.prodi,
    required this.judul,
    required this.tempatPenelitian,
    required this.alamatPenelitian,
  });

  factory USERRiset.fromJson(Map<String, dynamic> json) {
    return USERRiset(
      npm: json['npm'],
      nama: json['nama'],
      fakultas: json['fakultas'],
      prodi: json['prodi'],
      judul: json['judul'],
      tempatPenelitian: json['tempat_penelitian'],
      alamatPenelitian: json['alamat_penelitian'],
    );
  }
}
