class MahasiswaProfile {
  MahasiswaProfile({
    required this.data,
  });
  late final Data data;

  MahasiswaProfile.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.npm,
    required this.nama,
    required this.tmptLahir,
    required this.tglLahir,
    required this.jk,
    required this.agama,
    required this.provinsi,
    required this.kota,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelMhs,
    required this.rtMhs,
    required this.rwMhs,
    required this.nmAyah,
    required this.nmIbu,
    required this.alamatOrtu,
    required this.pekerjaanAyah,
    required this.pekerjaanIbu,
  });
  late final int npm;
  late final String nama;
  late final String tmptLahir;
  late final String tglLahir;
  late final String jk;
  late final String agama;
  late final String provinsi;
  late final String kota;
  late final String kabupaten;
  late final String kecamatan;
  late final String kelMhs;
  late final String rtMhs;
  late final String rwMhs;
  late final String nmAyah;
  late final String nmIbu;
  late final String alamatOrtu;
  late final String pekerjaanAyah;
  late final String pekerjaanIbu;

  Data.fromJson(Map<String, dynamic> json){
    npm = json['npm'];
    nama = json['nama'];
    tmptLahir = json['tmpt_lahir'];
    tglLahir = json['tgl_lahir'];
    jk = json['jk'];
    agama = json['agama'];
    provinsi = json['provinsi'];
    kota = json['kota'];
    kabupaten = json['kabupaten'];
    kecamatan = json['kecamatan'];
    kelMhs = json['kel_mhs'];
    rtMhs = json['rt_mhs'];
    rwMhs = json['rw_mhs'];
    nmAyah = json['nm_ayah'];
    nmIbu = json['nm_ibu'];
    alamatOrtu = json['alamat_ortu'];
    pekerjaanAyah = json['pekerjaan_ayah'];
    pekerjaanIbu = json['pekerjaan_ibu'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['npm'] = npm;
    _data['nama'] = nama;
    _data['tmpt_lahir'] = tmptLahir;
    _data['tgl_lahir'] = tglLahir;
    _data['jk'] = jk;
    _data['agama'] = agama;
    _data['provinsi'] = provinsi;
    _data['kota'] = kota;
    _data['kabupaten'] = kabupaten;
    _data['kecamatan'] = kecamatan;
    _data['kel_mhs'] = kelMhs;
    _data['rt_mhs'] = rtMhs;
    _data['rw_mhs'] = rwMhs;
    _data['nm_ayah'] = nmAyah;
    _data['nm_ibu'] = nmIbu;
    _data['alamat_ortu'] = alamatOrtu;
    _data['pekerjaan_ayah'] = pekerjaanAyah;
    _data['pekerjaan_ibu'] = pekerjaanIbu;
    return _data;
  }
}