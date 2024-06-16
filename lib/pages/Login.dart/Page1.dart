


import 'package:flutter/material.dart';

class Welcome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome page for InterStellar Vault',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }

}

class WelcomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Send Money', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
    );
  }

}