

class ProfileData {
  int? npm;
  String? nama;
  String? tmpt_lahir;
  String? tgl_lahir;
  String? jk;
  String? agama;
  String? provinsi;
  String? kota;
  String? kabupaten;
  String? kecamatan;
  String? kel_mhs;
  String? rt_mhs;
  String? rw_mhs;
  String? nm_ayah;
  String? nm_ibu;
  String? alamat_ortu;
  String? pekerjaan_ayah;
  String? pekerjaan_ibu;


  ProfileData({
    this.npm,
    this.nama,
    this.tmpt_lahir,
    this.tgl_lahir,
    this.jk,
    this.agama,
    this.provinsi,
    this.kota,
    this.kabupaten,
    this.kecamatan,
    this.kel_mhs,
    this.rt_mhs,
    this.rw_mhs,
    this.nm_ayah,
    this.nm_ibu,
    this.alamat_ortu,
    this.pekerjaan_ayah,
    this.pekerjaan_ibu,


  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      npm: json['npm'] as int?,
      nama: json['nama'] as String?,
      tmpt_lahir: json['tmpt_lahir'] as String?,
      tgl_lahir: json['tgl_lahir'] as String?,
      jk: json['jk'] as String?,
      agama: json['agama'] as String?,
      provinsi: json['provinsi'] as String?,
      kota: json['kota'] as String?,
      kabupaten: json['kabupaten'] as String?,
      kecamatan: json['kecamatan'] as String?,
      kel_mhs: json['kel_mhs'] as String?,
      rt_mhs: json['rt_mhs'] as String?,
      rw_mhs: json['rw_mhs'] as String?,
      nm_ayah: json['nm_ayah'] as String?,
      nm_ibu: json['nm_ibu'] as String?,
      alamat_ortu: json['alamat_ortu'] as String?,
      pekerjaan_ayah: json['pekerjaan_ayah'] as String?,
      pekerjaan_ibu: json['pekerjaan_ibu'] as String?,
    );
  }


  Map<String, dynamic> toJson() => {
    "npm": npm,
    "nama": nama,
    "tmpt_lahir": tmpt_lahir,
    "tgl_lahir": tgl_lahir,
    "jk": jk,
    "agama": agama,
    "provinsi": provinsi,
    "kota": kota,
    "kabupaten": kabupaten,
    "kecamatan": kecamatan,
    "kel_mhs": kel_mhs,
    "rt_mhs": rt_mhs,
    "rw_mhs": rw_mhs,
    "nm_ayah": nm_ayah,
    "nm_ibu": nm_ibu,
    "alamat_ortu": alamat_ortu,
    "pekerjaan_ayah": pekerjaan_ayah,
    "pekerjaan_ibu": pekerjaan_ibu,
  };
}
