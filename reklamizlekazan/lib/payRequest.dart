import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/AdmobHelper/admobHelper.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

class OdemeTalebiSayfasi extends StatefulWidget {
  const OdemeTalebiSayfasi({super.key});

  @override
  State<OdemeTalebiSayfasi> createState() => _OdemeTalebiSayfasiState();
}

class _OdemeTalebiSayfasiState extends State<OdemeTalebiSayfasi> {
  TextEditingController textFieldKayit = TextEditingController();
  String kayitliIban = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBarWidget(
          Colors.amber,
          const Text("IBAN Bilgileri"),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                const SizedBox(height: 20,),
                MySizedBoxWidget(
                  Get.height / 1.5,
                  Get.width,
                  Column(
                    children: [
                      MySizedBoxWidget(50, 320,
                          BannerAdmob(),
                          ), //banner gelecek

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                            inputFormatters:  [
                            FilteringTextInputFormatter.digitsOnly,
  ],
                          minLines: 1,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w300),
                          controller: textFieldKayit,
                          onChanged: (text) {
                            setState(() {
                               kayitliIban = text;
                            });
                          },
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.money), //// alana icon/simge verilebilir
                              hintText:
                                  "Iban Gir", //Bir ipucuna stil vermek için, bir hintStyle kullanın. Bir etiketi stillendirmek için, bir labelStyle kullanın.
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300, color: Colors.red),
                              border:
                                  OutlineInputBorder() //TextField öğesine bir sınır vermek için “border” kullanın.
                              ),
                        ),
                      ),
                     const SizedBox(height: 20,),
                      buttonMethod(
                        null,
                         Colors.orangeAccent,
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                           const Text("Kaydet"),),
                           const SizedBox(height: 20,),
                            Text("Kayıtlı IBAN: TR$kayitliIban"),
                           const SizedBox(height: 20,),
                            const Text("Puan : 0"),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.fromLTRB(0,Get.height/7,0,0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MySizedBoxWidget(
                          50, 320,  BannerAdmob(),
                    ), //banner gelecek
                          
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
