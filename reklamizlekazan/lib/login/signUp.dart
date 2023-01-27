import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/mainMenu.dart';
import 'package:reklamizlekazan/payRequest.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

class KayitOl extends StatefulWidget {
  const KayitOl({super.key});

  @override
  State<KayitOl> createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  FirebaseOptions firebaseoptions = FirebaseOptions();
  String firebaseUyari = "";
  bool sifre = true;

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> kayitOl() async {
    //kayıt ol
    try {
      await firebaseoptions.auth.createUserWithEmailAndPassword(
          email: t1.text, password: t2.text); //kullanıcı kayıtı
      Get.defaultDialog(
          middleText: "Şimdi Giriş Yapınız", title: "Kayıt Olundu!");
    } catch (e) {
      firebaseUyari = e.toString().substring(30);
    }
  }

  girisYap() {
    firebaseoptions.auth
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((value) {
      if (t1.text == "test@gmail.com" && t2.text == "123456") {
        Get.off(const OdemeTalebiSayfasi());
      } else {
        Get.off(const AnaMenu());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBarWidget(
          Colors.redAccent,
          const Text("Kayıt Ol Ve Giriş Yap"),
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
                () => setState(() {
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
                () => setState(() {
                  girisYap();
                }),
                Colors.redAccent,
                const EdgeInsets.all(25),
                const Text("Giriş Yap"),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  firebaseoptions.sifremiUnuttum();
                },
                child: const Text("Şifremi unuttum"),
              ),
              Text(firebaseUyari),
            ]),
          ),
        ),
      ),
    );
  }
}
