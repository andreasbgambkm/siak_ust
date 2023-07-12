class InfoTerkini {
  final String id_infoterkini;
  final String judul;
  final String isi;

  const InfoTerkini({
    required this.id_infoterkini,
    required this.judul,
    required this.isi,
  });

  factory InfoTerkini.fromJson(Map<String, dynamic> json) {
    return InfoTerkini(
      id_infoterkini: json['id_infoterkini'],
      judul: json['judul'],
      isi: json['isi'],
    );
  }
}