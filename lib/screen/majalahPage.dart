// ignore_for_file: file_names

import 'package:fit/screen/filteredMajalahPage.dart';
import 'package:fit/screen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/apiController.dart';
import '../widget/gridViewMajalah.dart';

class MajalahView extends GetView<ApiController> {
  const MajalahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Majalah MI',
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
                    child: GridViewMajalah(
                      controller: controller,
                      list: controller.majalahs,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: controller.majalahSearch,
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
                            controller.PerformSearchMajalah(
                                controller.majalahSearch.text);
                            Get.offAll(() => (FillteredMajalahView(
                                searchText: controller.majalahSearch.text)));
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
