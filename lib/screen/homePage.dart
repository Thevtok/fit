// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../widget/majalah.dart';
import '../widget/produk.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey[400],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              buildMajalahList(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              buildProdukList(context)
            ],
          ),
        ));
  }
}
