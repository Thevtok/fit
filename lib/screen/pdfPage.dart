// ignore_for_file: file_names

import 'package:fit/screen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

class PDFViewerView extends StatelessWidget {
  const PDFViewerView(this.pdfUrl, this.judul, {super.key});
  final String pdfUrl;
  final String judul;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => const HomeView());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blueAccent,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: const PDF().cachedFromUrl(pdfUrl),
      ),
    );
  }
}
