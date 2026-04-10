import 'package:flutter/material.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/sepetim.dart';

class Kitapligim extends StatelessWidget {
  const Kitapligim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text("Kitaplığım")),
      body: Center(child: Text("Henüz sepetine kitap eklemedin")),
      bottomNavigationBar: Anabottombar(),
    );
  }
}
