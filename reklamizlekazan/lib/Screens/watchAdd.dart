import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/AdmobHelper/admobHelper.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/Screens/mainMenu.dart';
import 'package:reklamizlekazan/controller/puanKontrol.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

class ReklamIzlemeSayfasi extends StatefulWidget {
  const ReklamIzlemeSayfasi({super.key});

  @override
  State<ReklamIzlemeSayfasi> createState() => _ReklamIzlemeSayfasiState();
}

class _ReklamIzlemeSayfasiState extends State<ReklamIzlemeSayfasi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green.shade100,
          appBar: MyAppBarWidget(
            Colors.blueAccent,
            const Text("Reklam İzleme Sayfası"),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.to(const AnaMenu());
              },
            ),
          ),
          body: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MySizedBoxWidget(
                  Get.height / 1.3,
                  Get.width,
                  Column(
                    children: [
                      MySizedBoxWidget(
                        50,
                        320,
                        BannerAdmob(),
                      ), //banner gelecek
    
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: buttonMethod(
                          () {
                            setState(() {
                              PuanTut.puanKontrol = 0;
                              Get.to(RewardedAdmob());
                            });
                          },
                          Colors.green,
                          const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          const Text("Reklam İzle"),
                        ),
                      ),
    
                      PuanTut.puan == 0
                          ? const Text("Puan: -")
                          : UserInformation2(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MySizedBoxWidget(
                      50,
                      320,
                      BannerAdmob(),
                    ), //banner
                  ],
                )
              ]),
        ),
      );
      
  }
}
