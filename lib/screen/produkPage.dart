// ignore_for_file: file_names

import 'package:fit/screen/filteredProdukPage.dart';
import 'package:fit/screen/homePage.dart';
import 'package:fit/widget/gridViewProduk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/apiController.dart';

class ProdukView extends GetView<ApiController> {
  const ProdukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Produk MI',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => const HomeView());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Obx(() => controller.isLoading.value
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.6),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: GridViewProduk(
                      controller: controller,
                      list: controller.produks,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: controller.produkMISearch,
                      decoration: InputDecoration(
                        hintText: 'Cari sesuatu',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 241, 244, 251),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 1,
                                  color: Colors.black.withOpacity(0.6),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            );

                            await Future.delayed(const Duration(seconds: 1));
                            controller.PerformSearchProduk(
                                controller.produkMISearch.text);

                            Get.offAll(() => (FillteredProdukView(
                                searchText: controller.produkMISearch.text)));
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 134, 132, 132),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )));
  }
}
