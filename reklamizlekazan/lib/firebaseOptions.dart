import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reklamizlekazan/controller/puanKontrol.dart';
import 'package:reklamizlekazan/widgets/widgets.dart';

import 'Screens/mainMenu.dart';

class FirebaseOptions {
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  sifremiUnuttum(String mail) async {
    await auth.sendPasswordResetEmail(email: mail);
    Get.defaultDialog(
        middleText: "sonra şifrenizi sıfırlayın",
        title: "Mailinizi Kontrol Edin!");
  }

  odemeTalebi() {
    if (PuanTut.puan > 100 && PuanTut.adSoyad != "") {
      FirebaseFirestore.instance
          .collection('Request')
          .doc(auth.currentUser!.email.toString())
          .set({
        'iban': UserInformationState.vtIban,
        'puan': UserInformation2State.vtPuan,
        "isim": PuanTut.adSoyad,
      });
      Get.defaultDialog(title: "Başarılı", middleText: "Talep iletildi beklemede kalınız");
    } else {
      Get.defaultDialog(
          title: "Puanın Yetersiz", middleText: "Puanın 100'den fazla olmalı ayrıca IBAN sahibini girmelisin");
    }
  }

  koleksiyonaKaydetIban(String kayitliIban) {
    if (kayitliIban == "") {
      Get.snackbar("Iban Boş Olamaz", "Lütfen Bir Değer Giriniz");
    } else  {
      collectionReference.doc(auth.currentUser!.email.toString()).update({
        'iban': kayitliIban,
      });
    }
   /* collectionReference.doc(auth.currentUser!.email.toString()).update({
      'iban': kayitliIban,
    });*/
  }

  koleksiyonaKaydetPuan(int puan) {
    if (puan == null) {
      collectionReference.doc(auth.currentUser!.email.toString()).set({
        'puan': puan,
      });
    }
    print("ilk yer${PuanTut.puanKontrol}");
    if (PuanTut.puanKontrol == 1) {
      puan++;
      collectionReference.doc(auth.currentUser!.email.toString()).update({
        'puan': puan,
      });
    }
  }
}

class UserInformation extends StatefulWidget {
  @override
  UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {
  FirebaseAuth auth = FirebaseAuth.instance;
  static String? vtIban;

  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email.toString())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (snapshot.data!.data() == null) {
          return const Text("IBAN: ");
        }
        var names = snapshot.data!.data() as Map<String, dynamic>;
        vtIban = names['iban'];
        return vtIban == null
            ? const Text("Kayıtlı IBAN -")
            : Text("Kayıtlı IBAN TR$vtIban");
      },
    );
  }
}

class UserInformation2 extends StatefulWidget {
  @override
  UserInformation2State createState() => UserInformation2State();
}

class UserInformation2State extends State<UserInformation2> {
  FirebaseAuth auth = FirebaseAuth.instance;
  static int? vtPuan;

  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email.toString())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        if (snapshot.data!.data() == null) {
          return const Text("Hadi Reklam İzle");
        }
        var names = snapshot.data!.data() as Map<dynamic, dynamic>;
        PuanTut.puan = names['puan'];
        vtPuan = names['puan'];

        return Text(
          "Puan: ${PuanTut.puan}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        );
      },
    );
  }
}

class YuksekPuanlilar extends StatefulWidget {
  const YuksekPuanlilar({super.key});

  @override
  State<YuksekPuanlilar> createState() => _YuksekPuanlilarState();
}

class _YuksekPuanlilarState extends State<YuksekPuanlilar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where("puan", isGreaterThan: 0)
                .orderBy("puan", descending: true)
                .limit(50)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                return Container();
              }
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              return Scaffold(
                appBar: MyAppBarWidget(
                  Colors.red,
                  const Text(
                    "En Yüksek Puana Sahip Kişiler",
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.offAll(const AnaMenu());
                    },
                  ),
                ),
                body: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 3, top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(184, 15, 233, 135),
                      ),
                      child: SingleChildScrollView(
                        child: ListTile(
                          title: Text(
                            "***${document.id.substring(3)}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          leading: Text("Puan:${document['puan']}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
