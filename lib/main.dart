import 'package:flutter/material.dart';
import 'package:kitapp/favorilerim.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/sepetim.dart';
import 'package:kitapp/mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: Icon(Icons.menu_book_rounded),
        title: Text(style: TextStyle(color: Colors.black), "KitApp"),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(height: 10),
            Stack(
              alignment: AlignmentGeometry.center,
              children: [
                GestureDetector(
                  onTap: () => print("tıklandı"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: const Color.fromARGB(255, 203, 202, 202),
                      ),
                    ),

                    width: double.infinity,
                    height: 40,
                    child: const Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 9),

                      child: Row(
                        children: [
                          Icon(Icons.search),
                          Text(" Kitap , yazar , kategori ara "),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                print("kategoriler kısmına tıklandı-roman"),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    203,
                                    202,
                                    202,
                                  ),
                                ),
                              ),
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsetsGeometry.all(8),
                            child: Text("Roman"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            print("kategoriler kısmına tıklandı-tarih"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 203, 202, 202),
                            ),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text("Tarih"),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            print("kategoriler kısmına tıklandı-deneme"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 203, 202, 202),
                            ),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text("Deneme"),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            print("kategoriler kısmına tıklandı-çocuk"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 203, 202, 202),
                            ),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text("Çocuk"),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            print("kategoriler kısmına tıklandı-dergi"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 203, 202, 202),
                            ),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text("Dergi"),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => print("kategoriler kısmına tıklandı-din"),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 203, 202, 202),
                            ),
                          ),
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text("Din"),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Anabottombar(),
    );
  }
}
