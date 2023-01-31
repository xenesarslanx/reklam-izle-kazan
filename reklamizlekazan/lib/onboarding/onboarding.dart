import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/login/signUp.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

class OnboardingIntro extends StatefulWidget {

  @override
  State<OnboardingIntro> createState() => _OnboardingIntroState();
}

class _OnboardingIntroState extends State<OnboardingIntro> {
  FirebaseOptions firebaseoptions = FirebaseOptions();
 static double? yukseklik = Get.height/2.5;
  List<Introduction> list = [
    Introduction(
      title: 'Kayıt Ol',
      subTitle: 'Kayıt olun emailinizi onaylayın ve giriş yapın',
      imageUrl: 'lib/images/kayit.jpg',
      imageHeight: yukseklik,
    ),
    Introduction(
      title: 'Reklam İzle',
      subTitle: 'Reklamları izleyip puan kazanın',
      imageUrl: 'lib/images/reklam.jpg',
      imageHeight: yukseklik,
    ),
    Introduction(
      title: 'Sıralamaya Gir',
      subTitle: 'Herkesten fazla reklam izleyerek sıralamaya gir',
      imageUrl: 'lib/images/max.jpg',
      imageHeight: yukseklik,
    ),
    Introduction(
      title: 'Para Kazan ',
      subTitle: '100\'den fazla puan kazanıp ödeme talep et ve para kazan',
      imageUrl: 'lib/images/iban.jpg',
      imageHeight: yukseklik,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        body: MySizedBoxWidget(Get.height, Get.width,
         IntroScreenOnboarding(
          introductionList: list,
          onTapSkipButton: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KayitOl(),
            ), 
          );
          },
          
        ),
      ),
      ),
      )
    );
  }
}
