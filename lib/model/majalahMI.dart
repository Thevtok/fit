// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

class MajalahMI {
  final String title;

  final Uint8List image;
  final String url;
  final String contentName;

  MajalahMI(
      {required this.title,
      required this.image,
      required this.url,
      required this.contentName});

  factory MajalahMI.fromJson(Map<String, dynamic> json) {
    return MajalahMI(
        title: json['webContentTittleTpNm'],
        image: base64.decode(json['webContentTittleImage']),
        url: json['webContentUrl'],
        contentName: json['webContentTittle']);
  }
}
