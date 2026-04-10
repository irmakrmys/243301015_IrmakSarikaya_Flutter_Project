import 'package:flutter/material.dart';

import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/sepetim.dart';

class Favorilerim extends StatelessWidget {
  const Favorilerim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Favorilerim"),
        centerTitle: true,
      ),
      body: Center(child: Text("Henüz favorilerine kitap eklemedin !")),

      bottomNavigationBar: Anabottombar(),
    );
  }
}
