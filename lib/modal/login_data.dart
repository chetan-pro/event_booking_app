// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    required this.success,
    required this.data,
    required this.error,
  });

  int success;
  Data data;
  String? error;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "error": error,
  };
}

class Data {
  Data({
    required this.success,
    required this.id,
    required this.name,
    required this.userLogin,
    required this.userEmail,
    required this.userRole,
  });

  int? success;
  int? id;
  String? name;
  int? userLogin;
  String? userEmail;
  UserRole userRole;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    id: json["ID"],
    name: json["name"],
    userLogin: json["user_login"],
    userEmail: json["user_email"],
    userRole: UserRole.fromJson(json["user_role"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "ID": id,
    "name": name,
    "user_login": userLogin,
    "user_email": userEmail,
    "user_role": userRole.toJson(),
  };
}

class UserRole {
  UserRole({
    required this.elEventManager,
  });

  dynamic elEventManager;

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
    elEventManager: json["el_event_manager"],
  );

  Map<String, dynamic> toJson() => {
    "el_event_manager": elEventManager,
  };
}
