import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseOptions{
  FirebaseAuth auth = FirebaseAuth.instance;

  sifremiUnuttum() async{
 await FirebaseAuth.instance.sendPasswordResetEmail(email: auth.currentUser!.email.toString());
 Get.defaultDialog(
  middleText: "sonra şifrenizi sıfırlayın", title: "Mailinizi Kontrol Edin!"
 );
  }
  
}