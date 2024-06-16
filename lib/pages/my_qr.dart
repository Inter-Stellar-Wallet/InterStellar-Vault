import 'package:animate_do/animate_do.dart';
import 'package:day40/helper/stellar.dart';
import 'package:day40/store/LoggedIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrCode extends StatelessWidget {

  const MyQrCode({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Qr Code', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              FadeInDown(
                from: 100,
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: 130,
                  height: 130,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("assets/images/avatar-1.png")),
                ),
              ),
              SizedBox(height: 15,),
              FadeInUp(
                from: 60,
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 1000),
                child: Text("Hello I am", style: TextStyle(color: Colors.grey),)),
              SizedBox(height: 10,),
              FadeInUp(
                from: 30,
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 1000),
                child: Text("Jhon", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
              SizedBox(height: 40,),
              FadeInUp(
                from: 30,
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 1000),
                child: Observer(
                  builder: (_) {
                    return QrImageView(
                      data: StellarHelper.keyPair0!.accountId.toString(),
                      version: QrVersions.auto,
                      size: 300.0,
                    );
                  }
                ),
                
              ),
              SizedBox(height: 40,),
              FadeIn(
                duration: const Duration(milliseconds: 500),
                child: MaterialButton(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  onPressed: () {},
                  child: const Text('Share', style: TextStyle(color: Colors.black, fontSize: 15),),
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
