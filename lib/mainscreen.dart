import 'package:flutter/material.dart';
import 'package:kitapp/favorilerim.dart';
import 'package:kitapp/hesabim.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/sepetim.dart';

class Anabottombar extends StatefulWidget {
  const Anabottombar({super.key});

  @override
  State<Anabottombar> createState() => _AnabottombarState();
}

class _AnabottombarState extends State<Anabottombar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => print("ana sayfa"),
            icon: Icon(Icons.home, color: Colors.red),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                //favorilerimm
                context,
                MaterialPageRoute(builder: (context) => const Favorilerim()),
              );
            },

            icon: Icon(Icons.favorite, color: Colors.red),
          ),

          CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Kitapligim()),
                );
              },

              icon: Icon(Icons.add, color: Colors.red),
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Sepetim()),
              );
            },
            icon: Icon(Icons.shopping_cart, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Hesabim()),
              );
            },
            icon: Icon(Icons.person, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
