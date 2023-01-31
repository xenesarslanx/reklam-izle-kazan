import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/Screens/mainMenu.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

class KayitOl extends StatefulWidget {
  const KayitOl({super.key});

  @override
  State<KayitOl> createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  FirebaseOptions firebaseoptions = FirebaseOptions();
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
 
  String firebaseUyari = "";
  bool sifre = true;

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
  if(FirebaseAuth.instance.currentUser != null){
   isEmailVerified =  FirebaseAuth.instance.currentUser!.emailVerified;
   print("initStateiçi$isEmailVerified");
  }
    if(!isEmailVerified){
   sendVerificationEmail();
  print("satır 42 print");
    }
   timer = Timer.periodic(const Duration(seconds: 3),
   (_) => checkEmailVerified(),
   );
    
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
Future checkEmailVerified() async {
  await FirebaseAuth.instance.currentUser!.reload();
  setState(() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    print("satır 5758 $isEmailVerified");
  });
  if(isEmailVerified) timer?.cancel();
  return isEmailVerified;
}

  Future sendVerificationEmail()async{
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    Get.defaultDialog(title: "Epostanızı kontrol edin!" , middleText: "Mailinizi Onaylayın!");
  }

  Future<void> kayitOl() async {
    //kayıt ol

    try {
      await firebaseoptions.auth.createUserWithEmailAndPassword(
          email: t1.text, password: t2.text).then((value) => sendVerificationEmail());
           
    } catch (e) {
      firebaseUyari = e.toString().substring(30);
      Get.defaultDialog(middleText: firebaseUyari);
    }
    collectionReference.doc(auth.currentUser!.email.toString())
    .set({
      'iban': "",
      'puan': 0,
      });
  }

  girisYap() async{
    try{
    await firebaseoptions.auth
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((value) {
      if (t1.text == "test@gmail.com" && t2.text == "123456") {
        Get.off( const AnaMenu());
      }else if (isEmailVerified == true) {
        print("calısması lazım");
        Get.off(const AnaMenu());
      }
         print("calısmadı");
    });
    }catch (e){
      Get.defaultDialog(middleText: e.toString().substring(30));
    }
  print("giris yap fonk $isEmailVerified");
  }
 /* @override
  void initState() {
      firebaseoptions.auth
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
       Get.offAll(const AnaMenu());
      print('User is signed in!');
      
    }
  });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBarWidget(
          Colors.redAccent,
          const Text("Kayıt Ol Ve Giriş Yap"),
          null
        ),
        body: SingleChildScrollView(
          child: MySizedBoxWidget(
            Get.height,
            Get.width,
            Column(children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: t1,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  hintText: 'Email ',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: t2,
                obscureText: sifre,
                decoration: InputDecoration(
                    icon: const Icon(Icons.password_sharp),
                    border: const OutlineInputBorder(),
                    hintText: 'Şifre ',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.red),
                    suffixIcon: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5)),
                        onPressed: () => setState(() {
                              sifre = !sifre;
                            }),
                        child: const Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.black,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonMethod(
                () => setState(()  {
                  kayitOl();
                }),
                Colors.red,
                const EdgeInsets.all(30),
                const Text("Kayıt Ol"),
              ),
              const SizedBox(
                height: 15,
              ),
              buttonMethod(
                () {
                  girisYap();
                }, 
                
                Colors.redAccent,
                const EdgeInsets.all(25),
                const Text("Giriş Yap"),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  if(t1.text.isEmail ){
                  firebaseoptions.sifremiUnuttum(t1.text);
                  Get.defaultDialog(middleText: "Epostanıza Gelen Şifre Değiştirme Talebini Onaylayın Ve Şifrenizi Değiştirin");
                  }else{
                  Get.defaultDialog(middleText: "Email Kısmına Mailinizi Yazın Ve Sonra 'Şifremi Unuttum'a Basın");
                  }
                },
                child: const Text("Şifremi Unuttum"),
              ),
              Text(firebaseUyari),
            ]),
          ),
        ),
      ),
    );
  }
}
