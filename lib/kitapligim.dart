import 'package:flutter/material.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/sepetim.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Kitapligim extends StatefulWidget {
  const Kitapligim({super.key});

  @override
  State<Kitapligim> createState() => _KitapligimState();
}

class _KitapligimState extends State<Kitapligim> {
  final TextEditingController adController = TextEditingController();
  final TextEditingController yazarController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();
  final TextEditingController kategoriController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Kitaplığım"),
        centerTitle: true,
      ),


      body: SingleChildScrollView(

      child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20))),

                  child: const Center(
                    child: Text(
                      "KİTAP EKLE",
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [

                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.grey),

                          ],
                        ),
                      ),
                  const SizedBox(height: 20),
                    customInput("Kitap Adı", adController),
                    const SizedBox(height: 10),
                    customInput("Yazar Adı", yazarController),
                    const SizedBox(height: 10),
                      customInput("Kategori", kategoriController),
                      const SizedBox(height: 10),
                    TextField(
                      controller: fiyatController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Fiyat",
                        suffixText: "TL",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        String kitap = adController.text.trim();
                        String yazar = yazarController.text.trim();
                        String fiyat = fiyatController.text.trim();
                        String kategori = kategoriController.text.trim();
                        if (kitap.isEmpty || yazar.isEmpty || fiyat.isEmpty || kategori.isEmpty) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Lütfen tüm alanları doldurun!"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }
                       kitapEkleFirebase();
                        print("Yayınla basıldı: ${adController.text}");
                      },
                      child: const Text("İlanı Yayınla",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                ],
                ),


                ),


              ],
          ),
      ),

          ),



      bottomNavigationBar: Anabottombar(),
    );
  }
  void kitapEkleFirebase() async{
    String kitapAdi=adController.text;
    String yazarAdi=yazarController.text;
    String fiyat=fiyatController.text;
    String kategori=kategoriController.text;
   try {
     await FirebaseFirestore.instance.collection('kitaplar').add({
       'kitapadi': kitapAdi,
         'yazar':yazarAdi,
         'fiyat':fiyat,
       'kategori':kategori,
     });
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text("Kitap başarıyla eklendi!")),
     );
     adController.clear();
     yazarController.clear();
     fiyatController.clear();
     kategoriController.clear();
   } catch(e) {
     print("hata oluştu$e");
   }
    }

Widget customInput(String baslik, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: baslik,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    ),
  );
}
}