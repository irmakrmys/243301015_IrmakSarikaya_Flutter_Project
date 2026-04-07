import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          leading: Icon(Icons.menu_book_rounded),
          title: Text(style: TextStyle(color: Colors.black), "KitApp"),
          centerTitle: true,

          actions: [
            IconButton(
              onPressed: () => print("ayarlara gidiliyor"),
              icon: Icon(Icons.settings, color: Colors.black),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: const Color.fromARGB(255, 203, 202, 202),
                  ),
                ),

                width: 500,
                height: 40,
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
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
                    SizedBox(width: 12),
                    Container(
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
                    SizedBox(width: 12),
                    Container(
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
                    SizedBox(width: 12),
                    Container(
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
                    SizedBox(width: 12),
                    Container(
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
                    SizedBox(width: 12),
                    Container(
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
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => print("ana sayfa"),
                icon: Icon(Icons.home, color: Colors.grey),
              ),

              IconButton(
                onPressed: () => print("favorilerim"),
                icon: Icon(Icons.favorite, color: Colors.grey),
              ),

              CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: IconButton(
                  onPressed: () => print("kitaplığım"),
                  icon: Icon(Icons.add, color: Colors.grey),
                ),
              ),

              IconButton(
                onPressed: () => print("sepet"),
                icon: Icon(Icons.shopping_cart, color: Colors.grey),
              ),
              IconButton(
                onPressed: () => print("hesabım"),
                icon: Icon(Icons.person, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
