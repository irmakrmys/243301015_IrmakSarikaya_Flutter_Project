import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitapp/Firebasecontrol/auth.dart';
import 'package:kitapp/main.dart';
import 'package:kitapp/mainscreen.dart';

import 'package:kitapp/kitapligim.dart';

import 'package:kitapp/sepetim.dart';

class Hesabim extends StatefulWidget {
  const Hesabim({super.key});

  @override
  State<Hesabim> createState() => _HesabimState();
}

class _HesabimState extends State<Hesabim> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool islogin=true;
  String?  errorMessage;
  Future<void> createUser() async{
try{
  await Auth().create_User(email: emailController.text, password: passwordController.text);
}  on FirebaseAuthException   catch(e){
setState(() {
  errorMessage=e.message;
});
}
  }

  Future<void> login() async{
   try{
      await Auth().login(
           email:emailController.text,
            password:passwordController.text,
);
   } on  FirebaseAuthException   catch(e){
setState(() {
  errorMessage=e.message;
});
   };
  }
  @override
  Widget build(BuildContext context) {
    final User? user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      return Scaffold(
        appBar:AppBar(
          title: Text("Profilim"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),

          body: Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 50,
                   child: Icon(Icons.person, color: Colors.grey,size: 40),
                ),

               Text("Hoşgeldin,\n${user.email}"),
                 SizedBox(height: 20,),
                   ElevatedButton(
                     onPressed: () async {
                       // Çıkış Yap butonu
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
        title: Text("Hesabım"),
        centerTitle: true,
      ),
      body: Center(
        child:Padding(
         padding: const EdgeInsets.all(30),
        child:Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Mailinizi giriniz",
                border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
SizedBox(height: 23),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Şifrenizi giriniz",
                  border:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
              ),

            ),
            ),
            SizedBox(height: 23),

           errorMessage!=null? Text(errorMessage!):const SizedBox.shrink(),
           ElevatedButton(

               onPressed: ()  async {
                 if (islogin) {
                   await login();
                 } else {
                   await createUser();
                 }
                 if (errorMessage == null) {
                   ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Griş yapıldı"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        )
                   );
                   setState(() {

                   });
                   Navigator.pushReplacement(context,
                     MaterialPageRoute(builder: (context) => MyApp()),

                   );
                 }
               },
                 child :islogin ? const Text("Giriş Yap"):const Text("Kaydol"),
           ),


            GestureDetector(
              onTap: (){
                setState(() {
                  islogin=!islogin;
                });
              },
              child: Text(
                  "Hesabın yok mu? Tıkla",
             style: TextStyle(fontSize: 18),
              ),
            ),
],
        ),
      ),
      ),

      bottomNavigationBar: Anabottombar(),
    );
  }
}
