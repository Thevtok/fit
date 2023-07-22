import 'package:fit/controller/apiController.dart';
import 'package:fit/screen/majalahPage.dart';
import 'package:fit/screen/pdfPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

final ApiController controller = Get.put(ApiController());
final Utils utils = Get.put(Utils());
// Fungsi yang mengembalikan widget FutureBuilder
Widget buildMajalahList(BuildContext context) {
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
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.85)),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        List.generate(controller.majalahs.length, (index) {
                      final majalah = controller.majalahs[index];

                      return Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onLongPress: () async {
                            controller.onTapItem(index);
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
                            Get.offAll(PDFViewerView(
                                majalah.url, majalah.contentName));
                          },
                          onTap: () async {
                            controller.onTapItem(index);
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
                            Get.offAll(PDFViewerView(
                                majalah.url, majalah.contentName));
                          },
                          child: Opacity(
                            opacity:
                                controller.tappedIndex.value == index ? 0.3 : 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.memory(
                                  majalah.image,
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  utils.getFormattedText(majalah.contentName),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Positioned(
                top: 13,
                right: 13,
                child: InkWell(
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
                    Get.offAll(() => const MajalahView());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Lihat semua',
                      style: TextStyle(
                        color: Colors.blueAccent, // Warna teks
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
                  'Majalah MI',
                  // controller.majalahs[0].title,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ));
}
