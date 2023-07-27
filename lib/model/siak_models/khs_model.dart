class KhsModel {
  UserKhs user;
  List<ComboboxKhs> combobox;

  KhsModel({required this.user, required this.combobox});

  factory KhsModel.fromJson(Map<String, dynamic> json) {
    return KhsModel(
      user: UserKhs.fromJson(json['user']),
      combobox: json['combobox'] != null
          ? List<ComboboxKhs>.from(json['combobox'].map((x) => ComboboxKhs.fromJson(x)))
          : [],
    );
  }
}

class UserKhs {
  int npm;
  String nama;
  String prodi;
  String fakultas;

  UserKhs({
    required this.npm,
    required this.nama,
    required this.prodi,
    required this.fakultas,
  });

  factory UserKhs.fromJson(Map<String, dynamic> json) {
    return UserKhs(
      npm: json['npm'],
      nama: json['nama'],
      prodi: json['prodi'],
      fakultas: json['fakultas'],
    );
  }
}

class ComboboxKhs {
  String id;
  String tahunAjaran;
  String semester;

  ComboboxKhs({required this.id, required this.tahunAjaran, required this.semester});

  factory ComboboxKhs.fromJson(Map<String, dynamic> json) {
    return ComboboxKhs(
      id: json['id'],
      tahunAjaran: json['tahun_ajaran'],
      semester: json['semester'],
    );
  }
}
