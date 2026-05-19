import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapp/main.dart';

class AdminPaneli extends StatelessWidget {
  const AdminPaneli({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Sistem Yönetim Paneli", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.orangeAccent),
          onPressed: () {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Anasayfa()),
            );
          },
        ),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(double.infinity, 45),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Admin Oturumunu Kapat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () async {

                await FirebaseAuth.instance.signOut();


                await logKaydet(islem: "Kullanıcı Çıkışı", detay: "Admin oturumu sonlandırıldı.");


                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Anasayfa()),
                      (route) => false,
                );
              },
            ),
          ),


          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: StreamBuilder<QuerySnapshot>(

                stream: FirebaseFirestore.instance
                    .collection('loglar')
                    .orderBy('zaman', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Hata: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final loglar = snapshot.data?.docs ?? [];

                  if (loglar.isEmpty) {
                    return const Center(child: Text("Sistemde henüz hiç log kaydı yok.", style: TextStyle(color: Colors.grey)));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: loglar.length,
                    itemBuilder: (context, index) {
                      final veri = loglar[index].data() as Map<String, dynamic>;


                      final Timestamp? ts = veri['zaman'] as Timestamp?;
                      String saatString = ts != null ? ts.toDate().toString().substring(0, 16) : "İşleniyor...";

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(

                          leading: const CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Icon(Icons.list_alt, color: Colors.white, size: 20),
                          ),
                          title: Text(
                            veri['islem'] ?? "Bilinmeyen İşlem",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(veri['detay'] ?? ""),
                          trailing: Text(
                            saatString,
                            style: const TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}