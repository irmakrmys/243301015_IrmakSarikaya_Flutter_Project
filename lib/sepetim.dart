import 'package:flutter/material.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/mainscreen.dart';

class Sepetim extends StatelessWidget {
  const Sepetim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Sepetim"),
        centerTitle: true,
      ),
      body: Center(child: Text("Henüz sepetine kitap eklemedin")),
      bottomNavigationBar: Anabottombar(),
    );
  }
}
