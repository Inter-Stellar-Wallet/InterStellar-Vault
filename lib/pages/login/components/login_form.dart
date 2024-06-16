// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day40/helper/stellar.dart';
import 'package:day40/store/LoggedIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:toastification/toastification.dart';

import '../../../constants.dart';

final db = FirebaseFirestore.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final LoggedInStore loggedInStore = LoggedInStore();

  @override
  void initState() {
    _getAllUsers();
    super.initState();
  }

  void _getAllUsers() async {
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  void _createUser() async {
    if (_formKey.currentState == null) return;

    final email = _formKey.currentState?.fields['email']?.value;
    final phone = _formKey.currentState?.fields['phone']?.value;

    final wallet = await _createWallet();

    if (wallet == null) {
      throw Exception('Wallet creation failed');
    }

    final user = <String, dynamic>{
      "email": email,
      "phone": phone,
      "accountId": StellarHelper.accountData!.accountId,
    };

    DocumentReference doc = await db.collection("users").add(user);
    print('DocumentSnapshot added with ID: ${doc.id}');

    context.read<LoggedInStore>().setWallet(wallet);
    context.read<LoggedInStore>().setIsLoggedIn(true);

    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: const Text("Wallet Creation Success"),
      description: const Text("Wallet created"),
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  Future<Wallet?> _createWallet() async {
    try {
      final wallet = await StellarHelper.createWallet();
      await StellarHelper.getKeyPair();
      await StellarHelper.fundAccount();
      await StellarHelper.getAccountData();

      return wallet;
    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: const Text("Wallet Creation Failed"),
        description: Text(e.toString()),
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 4),
      );

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'email',
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
              child: FormBuilderTextField(
                name: 'phone',
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: _createUser,
                  child: Text(
                    "Create Wallet".toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            const SizedBox(height: defaultPadding),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }
}
