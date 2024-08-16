import 'package:day40/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:day40/pages/home_page.dart';
import 'package:day40/store/LoggedIn.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(
    ToastificationWrapper(
      child: RootNavigator(),
    )
  );
}


class RootNavigator extends StatelessWidget {

  RootNavigator({Key? key}) : super(key: key);


  final LoggedInStore loggedInStore = LoggedInStore();

  final Fluttertoast ft = Fluttertoast();



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
                return const LoginScreen();
              }
            },
          );
        },
      ),
    );
  }
}