// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/majalahMI.dart';
import '../model/produkMI.dart';
import '../model/user.dart';

class ApiController extends GetxController {
  // Variabel untuk menyimpan index item yang sedang di-tap
  var tappedIndex = RxInt(-1);
  var tappedIndexP = RxInt(-1);
  var currentIndex = 0.obs;

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void onTapItem(int index) {
    tappedIndex.value = index;

    Future.delayed(const Duration(seconds: 1), () {
      tappedIndex.value = -1;
    });
  }

  void onTapItemP(int index) {
    tappedIndexP.value = index;

    Future.delayed(const Duration(seconds: 1), () {
      tappedIndexP.value = -1;
    });
  }

  var user = UserModel(
      username: '6285333111623',
      nomorKartuInhealth: '1001538370697',
      udid: '06abd25e57a14579',
      deviceType: 'Android',
      webContentTittleTp: '',
      offset: 0,
      limit: 100);

  @override
  void onInit() {
    super.onInit();
    getProdukMI(user);
    filteredProduks.assignAll(produks);
    getMajalahMI(user);
    filteredMajalahs.assignAll(majalahs);

    PerformSearchMajalah(majalahSearch.text);
    PerformSearchProduk(produkMISearch.text);
  }

  @override
  void dispose() {
    super.dispose();
    majalahSearch.dispose();
    produkMISearch.dispose();
  }

  static const encryptUrl =
      'https://development.inhealth.co.id/ft-svc/api/GeneratorInhealthEncryptDataWithPub';
  static const contentUrl =
      'https://development.inhealth.co.id/ft-svc/api/NWGetTrxWebContent';

  var majalahs = <MajalahMI>[].obs;
  var filteredMajalahs = <MajalahMI>[].obs;
  var produks = <ProdukMI>[].obs;
  var filteredProduks = <ProdukMI>[].obs;
  var inputText = ''.obs;
  var isLoading = false.obs;
  TextEditingController majalahSearch = TextEditingController();
  TextEditingController produkMISearch = TextEditingController();

  Future<List<ProdukMI>> getProdukMI(UserModel user) async {
    final dio = Dio();

    try {
      isLoading(true);
      final encryptResponse = await dio.post(encryptUrl, data: user.toJson());
      final String encryptedLink = encryptResponse.toString();
      final sanitizedEncryptedLink =
          encryptedLink.replaceAll("", ' ').replaceAll("'", '');
      final contentResponse =
          await dio.post(contentUrl, data: sanitizedEncryptedLink);

      if (contentResponse.statusCode == 200) {
        final responseData = jsonDecode(contentResponse.data);

        if (responseData == null || responseData["datas"] == null) {
          return [];
        }

        final datas = responseData["datas"];

        if (datas is List) {
          final List filteredData = datas
              .where((data) => data["webContentTittleTpNm"] == "Produk MI")
              .toList();

          final List<ProdukMI> produkData =
              filteredData.map((json) => ProdukMI.fromJson(json)).toList();

          produks.assignAll(produkData);
          return produkData;
        } else {
          produks.assignAll([]);
          return [];
        }
      } else {
        throw Exception(
            'Gagal mendapatkan data produk. Status: ${contentResponse.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan saat mengambil data produk: $error');
    } finally {
      isLoading(false);
    }
  }

  void PerformSearchProduk(String searchText) {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      filteredProduks.value = produks
          .where((produk) => produk.contentName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();

      isLoading.value = false;
      produkMISearch.clear();
    });
  }

  Future<List<MajalahMI>> getMajalahMI(UserModel user) async {
    final dio = Dio();

    try {
      isLoading(true);
      final encryptResponse = await dio.post(encryptUrl, data: user.toJson());
      final String encryptedLink = encryptResponse.toString();
      final sanitizedEncryptedLink =
          encryptedLink.replaceAll("", ' ').replaceAll("'", '');
      final contentResponse =
          await dio.post(contentUrl, data: sanitizedEncryptedLink);

      if (contentResponse.statusCode == 200) {
        final responseData = jsonDecode(contentResponse.data);

        if (responseData == null || responseData["datas"] == null) {
          return [];
        }

        final datas = responseData["datas"];

        if (datas is List) {
          final List filteredData = datas
              .where((data) => data["webContentTittleTpNm"] == "Majalah MI")
              .toList();

          final List<MajalahMI> majalahsData =
              filteredData.map((json) => MajalahMI.fromJson(json)).toList();

          majalahs.assignAll(majalahsData);

          return majalahsData;
        } else {
          majalahs.assignAll([]);
          return [];
        }
      } else {
        throw Exception(
            'Gagal mendapatkan data majalahs. Status: ${contentResponse.statusCode}');
      }
    } catch (error) {
      throw Exception('Terjadi kesalahan saat mengambil data majalahs: $error');
    } finally {
      isLoading(false);
    }
  }

  void PerformSearchMajalah(String searchText) {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      filteredMajalahs.value = majalahs
          .where((majalah) => majalah.contentName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();

      isLoading.value = false;
      majalahSearch.clear();
    });
  }
}
