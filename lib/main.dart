import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitapp/favorilerim.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/sepetim.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/kitaplar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kitapp/veriler.dart';

import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
try{
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  }catch(e){
  print("firebase başlatılamadı:$e");
  }
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    // Yeni açtığımız sayfadaki fonksiyonu tetikliyoruz:
    kitaplariOtomatikYukle();
  }
@override


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
                    child:  Padding(
                      padding:  const EdgeInsets.symmetric(horizontal: 9),

                      child: Row(
                        children: [
                          const  Icon(Icons.search),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Kitap, yazar, kategori ara",
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),

                      ),

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
                  Card(),
                  SizedBox(width: 12),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),

                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('kitaplar').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Bir hata oluştu: ${snapshot
                          .error}'));
                    }
final kitapsayisi= snapshot.data?.docs??[];

                    return GridView.builder(
                      itemCount: kitapsayisi.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final kitapverileri = kitapsayisi[index].data() as Map<String, dynamic>;
                        return Kitapcard(kitapverileri:kitapverileri);
                      }
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: Anabottombar(),
    );
  }
  Widget Kitapcard({required Map<String, dynamic> kitapverileri}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(

              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: kitapverileri['resimUrl'] != null && kitapverileri['resimUrl'].toString().isNotEmpty
                  ? Image.network(
                kitapverileri['resimUrl'],
                width: double.infinity,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[350],
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                  );
                },
              )
                  : Container(

                color: Colors.grey[350],
                width: double.infinity,
                child: const Icon(Icons.book, size: 50, color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(kitapverileri['kitapadi'] ?? 'isimsiz kitap',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(kitapverileri['yazar'] ?? 'bilinmeyen yazar',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${kitapverileri['fiyat'] ?? '0'}TL",
                        style: TextStyle(color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Icons.favorite, size: 18),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart, size: 18)),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  }
