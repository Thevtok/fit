// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fit/screen/majalahPage.dart';

import '../controller/apiController.dart';
import '../widget/gridViewMajalah.dart';

class FillteredMajalahView extends StatelessWidget {
  ApiController controller = Get.put(ApiController());
  var searchText = '';
  FillteredMajalahView({
    Key? key,
    required this.searchText,
  }) : super(key: key);

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
              Get.offAll(const MajalahView());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Obx(() => controller.isLoading.value
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.8),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onChanged: (text) {
                      controller.inputText.value =
                          text; // Update the searchText when the user types in the TextField
                    },
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
                        onPressed: () {
                          controller.PerformSearchMajalah(
                              controller.majalahSearch.text);
                          Get.to(FillteredMajalahView(
                              searchText: controller.majalahSearch.text));
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 134, 132, 132),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: GridViewMajalah(
                      controller: controller,
                      list: controller.filteredMajalahs,
                    ),
                  ),
                ),
              ])));
  }
}
