class SiakNotifikasiModel {
  UserNotif userNotif;
  List<Pengumuman> pengumuman;

  SiakNotifikasiModel({
    required this.userNotif,
    required this.pengumuman,
  });


  factory SiakNotifikasiModel.fromJson(Map<String, dynamic> json) {
    return SiakNotifikasiModel(
      userNotif: UserNotif.fromJson(json['user']),
      pengumuman: json['pengumuman'] != null ? List<Pengumuman>.from(
          json['pengumuman'].map((x) => Pengumuman.fromJson(x))) : [],

    );
  }
}

class Pengumuman {
  int idPengumuman;
  String isi;

  Pengumuman({
    required this.idPengumuman,
    required this.isi,
  });

  factory Pengumuman.fromJson(Map<String, dynamic> json) {
  return Pengumuman(
      idPengumuman: json['id_pengumuman'],
      isi: json['isi']




  );
  }

}

class UserNotif {
  String prodi;
  String fakultas;

  UserNotif({
    required this.prodi,
    required this.fakultas,
  });


  factory UserNotif.fromJson(Map<String, dynamic> json) {
    return UserNotif(
        prodi: json['prodi'],
        fakultas: json['fakultas']

    );
  }
}
