class PdfDownloadUrl {
  final String message;
  final String file;

  PdfDownloadUrl({
    required this.message,
    required this.file,
  });

  factory PdfDownloadUrl.fromJson(Map<String, dynamic> json) {
    return PdfDownloadUrl(
      message: json['message'],
      file: json['file'],
    );
  }
}
