import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:kitapp/main.dart';
import 'package:kitapp/favorilerim.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/sepetim.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/kitaplar.dart';
import 'package:kitapp/veriler.dart';

class Sepetim extends StatelessWidget {
  const Sepetim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Sepetim", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('kitapidleri')
              .doc('test_kitapidleri')
              .snapshots(),
          builder: (context, kullaniciSnapshot) {
            if (kullaniciSnapshot.hasError) {
              return Center(child: Text('Hata: ${kullaniciSnapshot.error}'));
            }

            if (kullaniciSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final kullaniciVerisi = kullaniciSnapshot.data?.data() as Map<String, dynamic>?;
            final List<dynamic> sepetIdListesi = kullaniciVerisi?['sepetim'] ?? [];

            if (sepetIdListesi.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 70, color: Colors.grey),
                    SizedBox(height: 15),
                    Text('Sepetiniz şu an boş.', style: TextStyle(color: Colors.grey, fontSize: 18)),
                  ],
                ),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('kitaplar')
                  .where(FieldPath.documentId, whereIn: sepetIdListesi)
                  .snapshots(),
              builder: (context, kitapSnapshot) {
                if (kitapSnapshot.hasError) {
                  return Center(child: Text('Kitaplar yüklenemedi: ${kitapSnapshot.error}'));
                }

                if (kitapSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final sepetKitaplar = kitapSnapshot.data?.docs ?? [];

                return GridView.builder(
                  itemCount: sepetKitaplar.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final kitapverileri = sepetKitaplar[index].data() as Map<String, dynamic>;
                    final stringKitapId = sepetKitaplar[index].id;

                    return SepetCard(
                      kitapverileri: kitapverileri,
                      kitapId: stringKitapId,
                    );
                  },
                );
              },
            );
          },
        ),
      ),


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {

            _odemeGoster(context);
          },
          child: const Text(
            "Satın al",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }


  void _odemeGoster(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(

          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kart bilgileri",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Kart Üzerindeki İsim",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),

              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Kart Numarası",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "AA / YY",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "CVC",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () async  {
                    await logKaydet(
                    islem: "Satın Alma",
                    detay: "test_kullanici sepetindeki kitapların ödemesini başarıyla tamamladı.",
                    );
                    Navigator.pop(context);


                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ödeme başarıyla alındı! Kitaplarınız hazırlanıyor.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text("Ödemeyi Tamamla", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  
  Widget SepetCard({required Map<String, dynamic> kitapverileri, required String kitapId}) {
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
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                ),
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
                      ),
                    ),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('kitapidleri')
                            .doc('test_kitapidleri')
                            .update({
                          'sepetim': FieldValue.arrayRemove([kitapId])
                        });
                      },
                      icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
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