import 'package:day40/helper/stellar.dart';
import 'package:day40/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:day40/pages/home_page.dart';
import 'package:day40/store/LoggedIn.dart';
import 'package:toastification/toastification.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ToastificationWrapper(
    child: RootNavigator(),
  ));
}

class RootNavigator extends StatelessWidget {
  const RootNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final LoggedInStore _loginStore = LoggedInStore();

    return MultiProvider(
      providers: [
        Provider(create: (_) => _loginStore),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Observer(
              builder: (_) {

                StellarHelper.getWallet().then((val) async => {

                  if (val == null) {
                    _.read<LoggedInStore>().setIsLoggedIn(false)
                  } else {
                    await StellarHelper.getKeyPair(),
                    await StellarHelper.getAccountData(),
                    _.read<LoggedInStore>().setWallet(val),
                    await StellarHelper.getAccountBalance().then((val) => {
                       _.read<LoggedInStore>().setBalance(val)
                    }),

                    _.read<LoggedInStore>().setIsLoggedIn(true)
                  }

                });

                if (_loginStore.isloggedin) {
                  return const HomePage();
                } else {
                  return const LoginScreen();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
