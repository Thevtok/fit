// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/apiController.dart';
import '../screen/pdfPage.dart';
import '../utils/utils.dart';

class GridViewMajalah extends StatelessWidget {
  GridViewMajalah({super.key, required this.controller, required this.list});

  final ApiController controller;
  final Utils utils = Utils();
  final RxList list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: GestureDetector(
            onLongPress: () async {
              controller.onTapItem(index);
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 1,
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
              Get.offAll(PDFViewerView(item.url, item.contentName));
            },
            onTap: () async {
              controller.onTapItem(index);
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 1,
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
              Get.offAll(PDFViewerView(item.url, item.contentName));
            },
            child: Opacity(
              opacity: controller.tappedIndex.value == index ? 0.3 : 1,
              child: Column(
                children: [
                  Image.memory(
                    item.image,
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      utils.getFormattedText(item.contentName),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
