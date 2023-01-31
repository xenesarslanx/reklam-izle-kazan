import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:reklamizlekazan/Screens/payRequest.dart';
import 'package:reklamizlekazan/Screens/watchAdd.dart';
import 'package:reklamizlekazan/firebaseOptions.dart';
import 'package:reklamizlekazan/controller/puanKontrol.dart';

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
  String bannerAdUnitId = 'ca-app-pub-2940256099942544/6300978111';

  @override
  String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917";

  @override
  String interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712";
}

class BannerAdmob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BannerAdmobState();
  }
}

class _BannerAdmobState extends State<BannerAdmob> {
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
        onAdLoaded: (ad) {
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
    return isLoaded
        ? SizedBox(
            child: AdWidget(ad: ad),
          )
        : Container();
  }
}

class RewardedAdmob extends StatefulWidget {
  @override
  State<RewardedAdmob> createState() => RewardedAdmobState();
}

class RewardedAdmobState extends State<RewardedAdmob> {
  late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = true;
  //FirebaseOptions firebaseOptions = FirebaseOptions();
  OdemeTalebiSayfasiState odm  = OdemeTalebiSayfasiState();
  @override
  void initState() {
    UserInformation();//
    super.initState();
    RewardedAd.load(
        adUnitId: TestId().rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _isRewardedAdReady = true;
          _rewardedAd = ad;
          print("444444444");
        }, onAdFailedToLoad: (error) {
          print("5555555555555");
          _isRewardedAdReady = false;

         dispose();
     }));
  }

  @override
  void dispose() {
    super.dispose();
    _rewardedAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: (() {
       
              setState(()  async { 
                if(_isRewardedAdReady == true) {
            await  _rewardedAd.show(
                   onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                    
                  Get.offAll(const ReklamIzlemeSayfasi());
            // FirebaseOptions.puan++;
             print("sayfa kapatildi2");
                }); 
                
          
            PuanTut.puanKontrol++;
           // PuanTut.puan++;   
             
             print("puan artt33${PuanTut.puan}");

              FirebaseOptions().koleksiyonaKaydetPuan(PuanTut.puan);
          
             print("koleksiyona kaydeedildiiiiiiii");

                }else{
                print("calısmadı");
                   
                }
             });
            
            }),
            child: const Text('Bas ve İzle'),
          );
             
 /*   _isRewardedAdReady == true
        ? ElevatedButton(
            onPressed: (() {
              setState(() {
                _rewardedAd.show(
                    onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                  Get.offAll(const ReklamIzlemeSayfasi());
                 // firebaseOptions.puan += 1;
                 // print("puan verildiiiiiiiiiiiiiiiiiiiiiiiii${firebaseOptions.puan}");
                });
              });
            }),
            child: const Text('Bas ve İzle'),
          )
        : Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.offAll(const ReklamIzlemeSayfasi());
                    }, //get to get of komutlarını yerlestır,//get to get of komutlarını yerlestır,//get to get of komutlarını yerlestır
                    child: const Text(
                      "Şuanlık Reklam Yok Daha Sonra Tekrar Deneyin",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ))
              ],
            ),
          );*/
  }
}
