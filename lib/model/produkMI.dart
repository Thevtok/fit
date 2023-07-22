// ignore_for_file: file_names

import 'dart:convert';
import 'dart:typed_data';

class ProdukMI {
  final String title;

  final Uint8List image;
  final String url;
  final String contentName;

  ProdukMI(
      {required this.title,
      required this.image,
      required this.url,
      required this.contentName});

  factory ProdukMI.fromJson(Map<String, dynamic> json) {
    return ProdukMI(
      title: json['webContentTittleTpNm'],
      image: base64.decode(json['webContentTittleImage']),
      url: json['webContentUrl'],
      contentName: json['webContentTittle'],
    );
  }
}
