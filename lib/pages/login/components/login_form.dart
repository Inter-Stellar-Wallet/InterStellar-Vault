import 'package:day40/helper/stellar.dart';
import 'package:day40/store/LoggedIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:toastification/toastification.dart';

import '../../../constants.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final LoggedInStore loggedInStore = LoggedInStore();


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          Observer(
            builder: (_) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black
                ),
                onPressed: () {
                    StellarHelper.createWallet().then((wallet) {
                      
                      loggedInStore.setWallet(wallet);
                      loggedInStore.setIsLoggedIn(true);
                      toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          style: ToastificationStyle.flat,
                          title: const Text("Wallet Creation Failed"),
                          description: const Text("Wallet created"),
                          alignment: Alignment.topLeft,
                          autoCloseDuration: const Duration(seconds: 4),
                        );

  
                    }).catchError((err) {
                        toastification.show(
                          context: context,
                          type: ToastificationType.error,
                          style: ToastificationStyle.flat,
                          title: const Text("Wallet Creation Failed"),
                          description: Text(err.toString()),
                          alignment: Alignment.topLeft,
                          autoCloseDuration: const Duration(seconds: 4),
                        );
                    });
                },
                child: Text(
                  "Create Wallet".toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),
              );
            }
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}