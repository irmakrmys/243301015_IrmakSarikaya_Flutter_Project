import 'package:flutter/material.dart';
import 'package:kitapp/mainscreen.dart';

import 'package:kitapp/kitapligim.dart';

import 'package:kitapp/sepetim.dart';

class Hesabim extends StatelessWidget {
  const Hesabim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red, title: Text("Hesabım")),
      bottomNavigationBar: Anabottombar(),
    );
  }
}
