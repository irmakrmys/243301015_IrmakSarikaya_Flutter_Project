import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapp/Firebasecontrol/auth.dart';
import 'package:kitapp/main.dart';
import 'package:kitapp/mainscreen.dart';
import 'package:kitapp/kitapligim.dart';
import 'package:kitapp/admin_paneli.dart';
import 'package:kitapp/sepetim.dart';

class Hesabim extends StatefulWidget {
  const Hesabim({super.key});

  @override
  State<Hesabim> createState() => _HesabimState();
}

class _HesabimState extends State<Hesabim> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool islogin = true;
  String? errorMessage;

  Future<void> createUser() async {
    try {
      await Auth().create_User(email: emailController.text, password: passwordController.text);
      setState(() {
        errorMessage = null;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> login() async {
    try {
      await Auth().login(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        errorMessage = null;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
String adminEmail="irmak@gmail.com";
    if (user != null) {
      if(user.email==adminEmail){
        return const AdminPaneli();
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profilim"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white54,
                radius: 50,
                child: Icon(Icons.person, color: Colors.grey, size: 40),
              ),
              const SizedBox(height: 10),
              Text("Hoşgeldin,\n${user.email}", textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Başarıyla çıkış yapıldı"),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  setState(() {});
                },
                child: const Text("Hesaptan Çıkış Yap"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Anabottombar(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Hesabım"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Mailinizi giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Şifrenizi giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                  ),


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  onPressed: () async {
                    if (islogin) {
                      await login();
                    } else {
                      await createUser();
                    }


                    if (errorMessage == null) {
                      if (islogin) {
                        await logKaydet(
                            islem: "Kullanıcı Girişi",
                            detay: "${emailController.text.trim()} sisteme başarıyla giriş yaptı."
                        );
                      } else {
                        await logKaydet(
                            islem: "Yeni Kullanıcı Kaydı",
                            detay: "Yeni bir kullanıcı başarıyla sisteme kaydoldu."
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(islogin ? "Giriş yapıldı" : "Kayıt başarıyla oluşturuldu"),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          )
                      );

                      String adminEmail = "irmak@gmail.com";


                      if (islogin && emailController.text.trim() == adminEmail) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const AdminPaneli()),
                        );
                      } else {

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Anasayfa()),
                        );
                      }
                    } else {

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("İşlem başarısız: $errorMessage"),
                            backgroundColor: Colors.redAccent,
                          )
                      );
                    }
                  },

                  child: islogin
                      ? const Text("Giriş Yap", style: TextStyle(color: Colors.white))
                      : const Text("Kaydol", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 23),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      islogin = !islogin;
                      errorMessage = null;
                    });
                  },
                  child: Text(
                    islogin ? "Hesabın yok mu? Tıkla" : "Zaten hesabın var mı? Giriş Yap",
                    style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Anabottombar(),
    );
  }
}