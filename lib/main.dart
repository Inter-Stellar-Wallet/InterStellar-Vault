import 'package:day40/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:day40/pages/home_page.dart';
import 'package:day40/store/LoggedIn.dart';


void main() {
  runApp(RootNavigator());
}


class RootNavigator extends StatelessWidget {

  final LoggedInStore loggedInStore = LoggedInStore();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Observer(
            builder: (_) {
              if (loggedInStore.isloggedin) {
                return const HomePage();
              } else {
                return LoginScreen();
              }
            },
          );
        },
      ),
    );
  }
}