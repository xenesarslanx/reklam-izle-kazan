import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/AdmobHelper/admobHelper.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/Screens/mainMenu.dart';
import 'package:reklamizlekazan/controller/puanKontrol.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

class OdemeTalebiSayfasi extends StatefulWidget {
  const OdemeTalebiSayfasi({super.key});

  @override
  State<OdemeTalebiSayfasi> createState() => OdemeTalebiSayfasiState();
}

class OdemeTalebiSayfasiState extends State<OdemeTalebiSayfasi> {
  TextEditingController textFieldKayit = TextEditingController();
  TextEditingController textFieldKayitIsim = TextEditingController();

  String kayitliIban = "";
  @override
  void initState() {
    UserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBarWidget(
          Colors.greenAccent,
          const Text("IBAN Bilgileri"),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(const AnaMenu());
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            MySizedBoxWidget(
              Get.height / 1.5,
              Get.width,
              Column(
                children: [
                  MySizedBoxWidget(
                    50,
                    320,
                    BannerAdmob(),
                  ), //banner gelecek

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      minLines: 1,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w300),
                      controller: textFieldKayit,
                      onChanged: (text) {
                        setState(() {
                          kayitliIban = text.toString();
                        });
                      },
                      decoration: const InputDecoration(
                          icon: Icon(
                              Icons.money), //// alana icon/simge verilebilir
                          hintText:
                              "Iban Gir", //Bir ipucuna stil vermek i??in, bir hintStyle kullan??n. Bir etiketi stillendirmek i??in, bir labelStyle kullan??n.
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.red),
                          border:
                              OutlineInputBorder() //TextField ????esine bir s??n??r vermek i??in ???border??? kullan??n.
                          ),
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w300),
                        controller: textFieldKayitIsim,
                        onChanged: (text) {
                          setState(() {
                           PuanTut.adSoyad = text.toString();
                          });
                        },
                        decoration: const InputDecoration(
                            icon: Icon(
                                Icons.person), //// alana icon/simge verilebilir
                            hintText:
                                "IBAN sahibinin Ad Soyad Girin", //Bir ipucuna stil vermek i??in, bir hintStyle kullan??n. Bir etiketi stillendirmek i??in, bir labelStyle kullan??n.
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300, color: Colors.red),
                            border:
                                OutlineInputBorder() //TextField ????esine bir s??n??r vermek i??in ???border??? kullan??n.
                            ),
                      ),
                  ),
                    const SizedBox(height: 20,),
                  buttonMethod(
                    () {
                      setState(() {
                        FirebaseOptions().koleksiyonaKaydetIban(kayitliIban);
                      });

                      print("basar??l??");
                    },
                    Colors.orangeAccent,
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    const Text("Kaydet"),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  UserInformation(),
                  const SizedBox(
                    height: 20,
                  ),

                  PuanTut.puan == 0
                      ? const Text("Puan: -")
                      : UserInformation2(),
                  const SizedBox(
                    height: 20,
                  ),
                  buttonMethod(() {
                    FirebaseOptions().odemeTalebi();
                  },
                      Colors.greenAccent,
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      const Text("??deme Talep Et")),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            /* Padding(
                  padding:  EdgeInsets.fromLTRB(0,Get.height/7,0,0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      
                      MySizedBoxWidget(
                          50, 320,  BannerAdmob(),
                    ), //banner gelecek
                          
                    ],
                  ),
                ),*/
          ]),
        ),
      ),
    );
  }
}
