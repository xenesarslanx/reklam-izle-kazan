import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/payRequest.dart';
import 'package:reklamizlekazan/watchAdd.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';
class AnaMenu extends StatefulWidget {
   const AnaMenu({super.key});

  @override
  State<AnaMenu> createState() => _AnaMenuState();
}

class _AnaMenuState extends State<AnaMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: MyAppBarWidget(Colors.amber, const Text("Ana Menü Sayfası"),  Size(Get.height/15, Get.width/15) ),
          //AppBar(title: const Text("Ana Menü Sayfası"),),
          body: MySizedBoxWidget(
          Get.height,
          Get.width,
          Column(
            children:   [
              MySizedBoxWidget(50, 320, const Text("Banner Reklam")),//banner gelecek

Padding(
  padding: const EdgeInsets.all(20.0),
  child:   buttonMethod(
  
   ()=> Get.to( const ReklamIzlemeSayfasi()),
  
     Colors.red,
  
      const EdgeInsets.symmetric(horizontal: 50,vertical:20),
  
       const Text("Reklam İzle"),
  
       ),
),

Padding(
  padding: const EdgeInsets.all(20.0),
  child:   buttonMethod(
  
   ()=> Get.to( null),
  
     Colors.red,
  
      const EdgeInsets.symmetric(horizontal: 50,vertical:20),
  
       const Text("Yüksek Puana Sahip Kişiler"),
  
       ),
),

     Padding(
       padding: const EdgeInsets.all(20.0),
       child: buttonMethod(
 ()=> Get.to( const OdemeTalebiSayfasi()),
   Colors.red,
    const EdgeInsets.symmetric(horizontal: 50,vertical:20),
       const Text("Ödeme Talep Et"),
       ),
     ),
     
   const Text(
    "Puanım: 0",
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    )
    ,),

     MySizedBoxWidget(50, 320, const Text("Banner Reklam")),//banner gelecek
      ],
          )
          ),
            
    
          ),
      ),
    );
  }

  
}


