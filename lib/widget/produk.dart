// ignore_for_file: unrelated_type_equality_checks

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fit/controller/apiController.dart';
import 'package:fit/screen/pdfPage.dart';
import 'package:fit/screen/produkPage.dart';
import 'package:fit/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ApiController controller = Get.put(ApiController());
final Utils utils = Get.put(Utils());

Widget buildProdukList(BuildContext context) {
  return Obx(() => controller.isLoading.value
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
      : Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.85)),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        controller.setCurrentIndex(index);
                      },
                      autoPlay: true,
                      aspectRatio: 16 / 5,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                    ),
                    items: List.generate(controller.produks.length, (index) {
                      final produk = controller.produks[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () async {
                            controller.onTapItemP(index);
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
                            Get.offAll(() =>
                                PDFViewerView(produk.url, produk.contentName));
                          },
                          onLongPress: () async {
                            controller.onTapItemP(index);
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
                            Get.offAll(() =>
                                PDFViewerView(produk.url, produk.contentName));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.01,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Opacity(
                              opacity: controller.tappedIndexP.value == index
                                  ? 0.3
                                  : 1,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 70),
                                          child: Text(
                                            produk.contentName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.memory(
                                        produk.image,
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 70,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.produks.length, (index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentIndex == index
                              ? Colors.orange
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Positioned(
                top: 13,
                right: 13,
                child: GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
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
                    Get.offAll(() => const ProdukView());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Lihat semua',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 13,
                left: 13,
                child: Text(
                  'Produk MI',
                  // controller.produks[0].title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )));
}
