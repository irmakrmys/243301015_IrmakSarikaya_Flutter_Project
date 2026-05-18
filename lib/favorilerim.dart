import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Favorilerim extends StatelessWidget {
  const Favorilerim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Favorilerim", style: TextStyle(color: Colors.black)),
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
            final List<dynamic> favoriIdListesi = kullaniciVerisi?['favori_kitaplar'] ?? [];


            if (favoriIdListesi.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 70, color: Colors.grey),
                    SizedBox(height: 15),
                    Text(
                      'Henüz favori kitabınız yok.',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('kitaplar')
                  .where(FieldPath.documentId, whereIn: favoriIdListesi)
                  .snapshots(),
              builder: (context, kitapSnapshot) {
                if (kitapSnapshot.hasError) {
                  return Center(child: Text('Kitaplar yüklenemedi: ${kitapSnapshot.error}'));
                }

                if (kitapSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final favoriKitaplar = kitapSnapshot.data?.docs ?? [];

                return GridView.builder(
                  itemCount: favoriKitaplar.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final kitapverileri = favoriKitaplar[index].data() as Map<String, dynamic>;
                    final stringKitapId = favoriKitaplar[index].id;

                    return Kitapcard(
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

    );
  }

  // ANA SAYFADAKİYLE AYNI TASARIMDA KART YAPISI:
  Widget Kitapcard({required Map<String, dynamic> kitapverileri, required String kitapId}) {
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

                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('kullanicilar')
                            .doc('test_kullanici')
                            .update({
                          'favori_kitaplar': FieldValue.arrayRemove([kitapId])
                        });
                      },
                      icon: const Icon(Icons.favorite, size: 18, color: Colors.red),
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