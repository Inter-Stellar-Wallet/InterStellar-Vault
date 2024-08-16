


import 'package:day40/store/LoggedIn.dart';
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

  final LoggedInStore loggedInStore = LoggedInStore();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Send Money', style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
      ),
      body: Center(
        child: Text("Hello123"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loggedInStore.setIsLoggedIn(true);
        } ,
      ),
    );
  }

}