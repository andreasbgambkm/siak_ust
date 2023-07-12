import 'dart:convert';

LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final LoginData data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = LoginData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class LoginData {
  LoginData({

    required this.id,
    required this.password,
    required this.level,
    required this.Sts,
    required this.login_terakhir,
  required this.ip_log,
  required this.com_name,
  required this.ip,
  required this.ip2,
  required this.webu,
    required this.access_token,
  });
  late final String id;
  late final String password;
  late final String level;
  late final String Sts;
  late final String login_terakhir;
  late final String ip_log;
  late final String com_name;
  late final String ip;
  late final String ip2;
  late final String webu;
  late final String access_token;


  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    level = json['level'];
    Sts = json['Sts'];
    login_terakhir = json['login_terakhir'];

    ip_log = json['ip_log'];
    com_name = json['com_name'];
    ip = json['ip'];
    ip2 = json['ip2'];
    webu = json['webu'];
    access_token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['password'] = password;
    _data['level'] = level;
    _data['Sts'] = Sts;
    _data['login_terakhir'] = login_terakhir;

    _data['ip_log'] = ip_log;
    _data['com_name'] = com_name;
    _data['ip'] = ip;
    _data['ip2'] = ip2;
    _data['webu'] = webu;
     _data['access_token'] = access_token;
    return _data;
  }
}