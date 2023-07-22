import 'dart:convert';

import 'package:dio/dio.dart';

class UserModel {
  String username;
  String nomorKartuInhealth;
  String udid;
  String deviceType;
  String webContentTittleTp;
  int offset;
  int limit;

  UserModel({
    required this.username,
    required this.nomorKartuInhealth,
    required this.udid,
    required this.deviceType,
    required this.webContentTittleTp,
    required this.offset,
    required this.limit,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      nomorKartuInhealth: json['nomorKartuInhealth'],
      udid: json['udid'],
      deviceType: json['deviceType'],
      webContentTittleTp: json['webContentTittleTp'],
      offset: json['offset'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nomorKartuInhealth': nomorKartuInhealth,
      'udid': udid,
      'deviceType': deviceType,
      'webContentTittleTp': webContentTittleTp,
      'offset': offset,
      'limit': limit,
    };
  }

  Map<String, dynamic> extractResponseBody(Response<dynamic> response) {
    final responseBody = response.toString();
    // Hapus karakter kutip ganda ("), kutip tunggal ('), dan backtick (`) dari response body
    final sanitizedBody = responseBody
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll("`", '');

    // Convert sanitizedBody dari String menjadi Map<String, dynamic>
    return jsonDecode(sanitizedBody);
  }
}
