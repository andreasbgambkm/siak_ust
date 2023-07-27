import 'package:siak/model/siak_models/user_model.dart';

class ProfileMahasiswa extends User{
  int? npm;
  String? nama;
  String? fakultas;
  String? prodi;
  String? tempatLahir;
  DateTime? tanggalLahir;
  String? jenisKelamin;
  String? agama;
  String? provinsi;
  String? kota;
  String? kabupaten;
  String? kecamatan;
  String? kelurahanMahasiswa;
  String? rtMahasiswa;
  String? rwMahasiswa;
  String? namaAyah;
  String? namaIbu;
  String? alamatOrtu;
  String? pekerjaanAyah;
  String? pekerjaanIbu;
  String? foto;

  ProfileMahasiswa({
    this.npm,
    this.nama,
    this.fakultas,
    this.prodi,
    this.tempatLahir,
    this.tanggalLahir,
    this.jenisKelamin,
    this.agama,
    this.provinsi,
    this.kota,
    this.kabupaten,
    this.kecamatan,
    this.kelurahanMahasiswa,
    this.rtMahasiswa,
    this.rwMahasiswa,
    this.namaAyah,
    this.namaIbu,
    this.alamatOrtu,
    this.pekerjaanAyah,
    this.pekerjaanIbu,
    this.foto
  });

  factory ProfileMahasiswa.fromJson(Map<dynamic, dynamic> json) {
    return ProfileMahasiswa(
      npm: json['npm'],
      nama: json['nama'],
      fakultas: json['fakultas'],
      prodi: json['prodi'],
      tempatLahir: json['tmpt_lahir'],
      tanggalLahir: DateTime.parse(json['tgl_lahir']),
      jenisKelamin: json['jk'],
      agama: json['agama'],
      provinsi: json['provinsi'],
      kota: json['kota'],
      kabupaten: json['kabupaten'],
      kecamatan: json['kecamatan'],
      kelurahanMahasiswa: json['kel_mhs'],
      rtMahasiswa: json['rt_mhs'],
      rwMahasiswa: json['rw_mhs'],
      namaAyah: json['nm_ayah'],
      namaIbu: json['nm_ibu'],
      alamatOrtu: json['alamat_ortu'],
      pekerjaanAyah: json['pekerjaan_ayah'],
      pekerjaanIbu: json['pekerjaan_ibu'],
      foto:   json['foto'],
    );
  }
}
