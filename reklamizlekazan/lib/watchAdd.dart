import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

import 'AdmobHelper/admobHelper.dart';

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
        appBar: MyAppBarWidget(
          Colors.amber,
          const Text("Reklam İzleme Sayfası"),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MySizedBoxWidget(
                Get.height/1.3,
                Get.width,
                Column(
                  children: [
                    MySizedBoxWidget(
                        50, 320, BannerAdmob(),), //banner gelecek

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: buttonMethod(
                  () => Get.to( RewardedAdmob()),

                        Colors.green,
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        const Text("Reklam İzle"),
                      ),
                    ),
                  ],
                ),  
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                   MySizedBoxWidget(50, 320, BannerAdmob(),),//banner 
                ],
              )
            ]),
      ),
    );
  }
}
