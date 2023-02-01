import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/Screens/payRequest.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/controller/puanKontrol.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';
import '../AdmobHelper/admobHelper.dart';
import 'watchAdd.dart';

class AnaMenu extends StatefulWidget {
  const AnaMenu({super.key});

  @override
  State<AnaMenu> createState() => _AnaMenuState();
}

class _AnaMenuState extends State<AnaMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.yellow.shade400,
        appBar: MyAppBarWidget(
          Colors.yellow.shade600,
          const Text("Ana Menü"),
          null,
        ),
        //AppBar(title: const Text("Ana Menü Sayfası"),),
        body: MySizedBoxWidget(
            Get.height,
            Get.width,
            Column(
              children: [
                MySizedBoxWidget(50, 320, BannerAdmob()), //banner gelecek

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: buttonMethod(
                    () => Get.offAll(const ReklamIzlemeSayfasi()),
                    Colors.blueAccent,
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    const Text("Reklam İzle"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: buttonMethod(
                    () => Get.to(const YuksekPuanlilar()),
                    Colors.red,
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    const Text("Yüksek Puana Sahip Kişiler"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: buttonMethod(
                    () => Get.offAll(const OdemeTalebiSayfasi()),
                    Colors.greenAccent,
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    const Text("Ödeme Talep Et"),
                  ),
                ),

                PuanTut.puan == null
                    ? const Text("Puan: -")
                    : UserInformation2(),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, Get.height / 4, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MySizedBoxWidget(50, 320, BannerAdmob()), //banner gelecek
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
