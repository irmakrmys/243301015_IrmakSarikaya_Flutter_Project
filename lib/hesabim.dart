import 'package:flutter/material.dart';
import 'package:kitapp/main.dart';
import 'package:kitapp/mainscreen.dart';

import 'package:kitapp/kitapligim.dart';

import 'package:kitapp/sepetim.dart';

class Hesabim extends StatelessWidget {
  const Hesabim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Hesabım"),
        centerTitle: true,
      ),
      body: Center(
        child:Padding(
         padding: const EdgeInsets.all(30),
        child:Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Mailinizi giriniz",
                border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
SizedBox(height: 23),
            TextField(
              decoration: InputDecoration(
                hintText: "Şifrenizi giriniz",
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
              ),

            ),
            ),
            SizedBox(height: 23),
           ElevatedButton(
             child: Text(  "Giriş yap"),
               onPressed:
                   () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => MyApp()),
                 );
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: const Text('Başarıyla üye oldunuz!'),
                     duration: const Duration(seconds: 3),
                     backgroundColor: Colors.green,
                     behavior: SnackBarBehavior.floating,
                   ),
                 );
               }
               ,

           ),
          ],
        )
        ),
      ),

      bottomNavigationBar: Anabottombar(),
    );
  }
}
