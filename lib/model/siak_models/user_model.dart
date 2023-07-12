// To parse this JSON data, do
//
//     final siakLoginApi = siakLoginApiFromJson(jsonString);

import 'dart:convert';

// List<SiakLoginApi> siakLoginApiFromJson(String str) => List<SiakLoginApi>.from(json.decode(str).map((x) => SiakLoginApi.fromJson(x)));
//
// String siakLoginApiToJson(List<SiakLoginApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class SiakLoginApi {
//   SiakLoginApi({
//     required this.id,
//     required this.password,
//     required this.level,
//     required this.sts,
//     required this.loginTerakhir,
//     required this.ipLog,
//     required this.comName,
//     required this.ip,
//     required this.ip2,
//     required this.webu,
//   });
//
//   String id;
//   String password;
//   String level;
//   String sts;
//   DateTime loginTerakhir;
//   String ipLog;
//   String comName;
//   String ip;
//   String ip2;
//   String webu;
//
//   factory SiakLoginApi.fromJson(Map<String, dynamic> json) => SiakLoginApi(
//     id: json["id"],
//     password: json["password"],
//     level: json["level"],
//     sts: json["Sts"],
//     loginTerakhir: DateTime.parse(json["login_terakhir"]),
//     ipLog: json["ip_log"],
//     comName: json["com_name"],
//     ip: json["ip"],
//     ip2: json["ip2"],
//     webu: json["webu"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "password": password,
//     "level": level,
//     "Sts": sts,
//     "login_terakhir": loginTerakhir.toIso8601String(),
//     "ip_log": ipLog,
//     "com_name": comName,
//     "ip": ip,
//     "ip2": ip2,
//     "webu": webu,
//   };
// }

class User{
  String id;
  String token;

  User({this.id="", this.token=""});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      token: json['token'],

    );

  }
}
