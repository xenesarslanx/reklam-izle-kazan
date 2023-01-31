import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reklamizlekazan/onboarding/onboarding.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          "lib/images/logom.png"
        ),
        backgroundColor: Colors.white,
        splashIconSize: 400,
        splashTransition: SplashTransition.scaleTransition,
         nextScreen:  OnboardingIntro(),
)
    );
  }
}
