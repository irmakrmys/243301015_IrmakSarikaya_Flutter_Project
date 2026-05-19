import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'package:kitapp/favorilerim.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/sepetim.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/kitaplar.dart';
import 'package:kitapp/veriler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    print("firebase başlatılamadı:$e");
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    kitaplariOtomatikYukle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String secilenKategori = "Roman";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: const Icon(Icons.menu_book_rounded),
        title: const Text("KitApp", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color.fromARGB(255, 203, 202, 202)),
                ),
                width: double.infinity,
                height: 40,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Kitap, yazar, kategori ara",
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  _buildKategoriKutusu("Roman", () {
                    setState(() {
                      secilenKategori = "Roman";
                    });
                  }),
                  const SizedBox(width: 12),
                  _buildKategoriKutusu("Tarih", () {
                    setState(() {
                      secilenKategori = "Tarih";
                    });
                  }),
                  const SizedBox(width: 12),
                  _buildKategoriKutusu("Deneme", () {
                    setState(() {
                      secilenKategori = "Deneme";
                    });
                  }),
                  const SizedBox(width: 12),
                  _buildKategoriKutusu("Çocuk", () {
                    setState(() {
                      secilenKategori = "Çocuk";
                    });
                  }),
                  const SizedBox(width: 12),
                  _buildKategoriKutusu("Din", () {
                    setState(() {
                      secilenKategori = "Din";
                    });
                  }),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('kitaplar')
                      .where('kategori', isEqualTo: secilenKategori)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final kitapsayisi = snapshot.data?.docs ?? [];

                    if (kitapsayisi.isEmpty) {
                      return const Center(
                        child: Text(
                          "Bu kategoride henüz kitap bulunamadı.",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    }

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
                        final stringKitapId = kitapsayisi[index].id;

                        return Kitapcard(
                          kitapverileri: kitapverileri,
                          kitapId: stringKitapId,
                          context: context,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Anabottombar(),
    );
  }

  Widget _buildKategoriKutusu(String baslik, VoidCallback onTap) {
    final bool isSelected = secilenKategori == baslik;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.redAccent.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.redAccent : const Color.fromARGB(255, 203, 202, 202),
            width: isSelected ? 2 : 1,
          ),
        ),
        width: 100,
        height: 45,
        padding: const EdgeInsets.all(8),
        child: Text(
          baslik,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.redAccent : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget Kitapcard({
    required Map<String, dynamic> kitapverileri,
    required String kitapId,
    required BuildContext context
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: kitapverileri['gorsel'] != null && kitapverileri['gorsel'].toString().isNotEmpty
                  ? Image.network(
                kitapverileri['gorsel'],
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
                Text(
                  kitapverileri['kitapadi'] ?? 'İsimsiz Kitap',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  kitapverileri['yazar'] ?? 'Bilinmeyen Yazar',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${kitapverileri['fiyat'] ?? '0'} TL",
                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Dinamik Favori Butonu
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        final String? mevcutKullaniciUid = FirebaseAuth.instance.currentUser?.uid;
                        if (mevcutKullaniciUid != null) {
                          await FirebaseFirestore.instance
                              .collection('kitapidleri')
                              .doc(mevcutKullaniciUid) // DİNAMİK UID BAĞLANDI
                              .set({
                            'favori_kitaplar': FieldValue.arrayUnion([kitapId])
                          }, SetOptions(merge: true));

                          print("${kitapverileri['kitapadi']} favorilere eklendi!");
                        }
                      },
                      icon: const Icon(Icons.favorite, size: 18, color: Colors.red),
                    ),
                    const SizedBox(width: 5),
                    // Dinamik Sepet Butonu
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        final String? mevcutKullaniciUid = FirebaseAuth.instance.currentUser?.uid;
                        if (mevcutKullaniciUid != null) {
                          await FirebaseFirestore.instance
                              .collection('kitapidleri')
                              .doc(mevcutKullaniciUid) // DİNAMİK UID BAĞLANDI
                              .set({
                            'sepetim': FieldValue.arrayUnion([kitapId])
                          }, SetOptions(merge: true));

                          print("${kitapverileri['kitapadi']} sepete eklendi!");

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${kitapverileri['kitapadi']} sepete eklendi!'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                    ),
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

Future<void> logKaydet({required String islem, required String detay}) async {
  try {
    await FirebaseFirestore.instance.collection('loglar').add({
      'islem': islem,
      'detay': detay,
      'zaman': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    print("Log yazılırken hata oluştu: $e");
  }
}