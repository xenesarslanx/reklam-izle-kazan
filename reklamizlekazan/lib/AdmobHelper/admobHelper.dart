import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reklamizlekazan/watchAdd.dart';

abstract class Admob {
  String get bannerAdUnitId;
  String get rewardedAdUnitId;
  String get interstitialAdUnitId;
}

class RealId implements Admob {
  @override
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5722581928261637/6605956742';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isWindows) {
      return '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  @override
  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5722581928261637/6605956742';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isWindows) {
      return '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  @override
  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5722581928261637/6605956742';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isWindows) {
      return '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}

class TestId implements Admob {
  @override
  String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  @override
  String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917";

  @override
  String interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712";
}

  
  








  class BannerAdmob extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BannerAdmobState();
  }
}

class _BannerAdmobState extends State<BannerAdmob>{

  late BannerAd ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    ad = BannerAd(
      adUnitId: TestId().bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isLoaded = true;
            print("1111111111111111111111111111111111111111111111");
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            isLoaded = false;
            print("222222222222222222222222222222222222222222222222");

          });
          ad.dispose();
        },
      ),
    );
    ad.load();
  }

  @override
  void dispose() {
    super.dispose();
    ad.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded?
    SizedBox(
      child: AdWidget(ad: ad),
    ):Container();
  }
}

class RewardedAdmob extends StatefulWidget {

  @override
  State<RewardedAdmob> createState() => _RewardedAdmobState();
}

class _RewardedAdmobState extends State<RewardedAdmob> {
   late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  @override
  void initState(){
super.initState();
  RewardedAd.load(
       adUnitId: TestId().rewardedAdUnitId,
        request: const AdRequest(),
         rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad){
           _rewardedAd = ad;
           _isRewardedAdReady = true;
           print("444444444");
         },
          onAdFailedToLoad:(error){
           print("5555555555555");

          }
         ));
}
@override
  void dispose() {
    super.dispose();
    _rewardedAd.dispose();
  }


  @override
  Widget build(BuildContext context) {
   return _isRewardedAdReady
? ElevatedButton(
onPressed:(() => 
_rewardedAd.show(
  onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {  
    Get.to(const ReklamIzlemeSayfasi());
  })
),
child: const Text('Bas ve İzle'),
)
: Container(
  color: Colors.red,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children:  [
      ElevatedButton(
        onPressed: (){Get.to(const ReklamIzlemeSayfasi());},//get to get of komutlarını yerlestır,//get to get of komutlarını yerlestır,//get to get of komutlarını yerlestır
         child:  const Text("Şuanlık Reklam Yok Daha Sonra Tekrar Deneyin",style:
       TextStyle(
        color: Colors.black,
        fontSize: 22,

        ),))
      
    ],
  ),
);    
  }
}