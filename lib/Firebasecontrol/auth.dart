
import 'package:firebase_auth/firebase_auth.dart';
class Auth{
 final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

 User? get currentUser => firebaseAuth.currentUser;
Stream<User?> get authChanges=> firebaseAuth.authStateChanges();//değişiklerden haber olcaz

 Future<void> create_User({

   required String email,
   required String password,
}) async{
   await firebaseAuth.createUserWithEmailAndPassword
     (email: email,
       password: password
   );
 }
Future<void> login({
   required String email,
  required String password,
}) async {
   await  firebaseAuth.signInWithEmailAndPassword(
       email: email,
       password: password,
   );
}
 Future<void> signout() async {
   await firebaseAuth.signOut();
}
 }