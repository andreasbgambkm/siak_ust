class SuratPermohonan {
  UserSP user;
  List<DaftarSurat> daftarSurat;

  SuratPermohonan({
    required this.user,
    required this.daftarSurat,
  });


  factory SuratPermohonan.fromJson(Map<String, dynamic> json) {
    return SuratPermohonan(
      user: UserSP.fromJson(json['user']),
      daftarSurat: json['daftar_surat'] != null ? List<DaftarSurat>.from(json['daftar_surat'].map((x) => DaftarSurat.fromJson(x))) :[],

    );
  }
}

class DaftarSurat {
  String idSurat;
  String jenisSurat;

  DaftarSurat({
    required this.idSurat,
    required this.jenisSurat,
  });

  factory DaftarSurat.fromJson(Map<String, dynamic> json) {
    return DaftarSurat(
        idSurat: json['ID_Surat'],
        jenisSurat:json['Jenis_Surat']

    );
  }


}

class UserSP {
  String prodi;
  String fakultas;

  UserSP({
    required this.prodi,
    required this.fakultas,
  });

  factory UserSP.fromJson(Map<String, dynamic> json) {
    return UserSP(

      prodi: json['prodi'],
      fakultas: json['fakultas'],

    );
  }



}
