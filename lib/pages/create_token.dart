// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:interstellar/constants.dart';
import 'package:interstellar/helper/stellar.dart';
import 'package:interstellar/store/LoggedIn.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CreateTokenPage extends StatefulWidget {
  final String name;
  final String avatar;
  final String? qr_data;
  const CreateTokenPage(
      {Key? key, required this.name, required this.avatar, this.qr_data})
      : super(key: key);

  @override
  _CreateTokenPageState createState() => _CreateTokenPageState();
}

class _CreateTokenPageState extends State<CreateTokenPage> {
  var amount = TextEditingController(text: "0.00");
  final _formKey = GlobalKey<FormBuilderState>();
  final LoggedInStore loggedInStore = LoggedInStore();

  bool isFocused = false;

  String phone = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getDetails();
  }


  void getDetails() {
    print(widget.qr_data);

    final users = context.read<LoggedInStore>().users;

    for (var user in users) {
      if (user.accountId == widget.qr_data) {
        setState(() {
          phone = user.phone;
          email = user.email;
        });
        return;
      }
    }

    setState(() {
      phone = '';
      email = widget.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Buisness Coin',
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
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
                        child: Image.asset(widget.avatar)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FadeInUp(
                    from: 30,
                    delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 1000),
                    child: Text(
                      email,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 60),
                  child: Form(
                    child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'Coin Name',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          onSaved: (email) {},
                          decoration: const InputDecoration(
                            hintText: "Bitcoin",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(Iconsax.coin),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
                          child: FormBuilderTextField(
                            name: 'Supply',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            cursorColor: kPrimaryColor,
                            decoration: const InputDecoration(
                              hintText: "3000",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0),
                                child: Icon(Icons.token),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding*2),
                        Observer(
                          builder: (_) {
                            return ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(backgroundColor: Colors.black),
                              onPressed: (){},
                              child: Text(
                                "Create Token".toUpperCase(),
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
                ),
                ),
                
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      child: Observer(builder: (_) {
                        return MaterialButton(
                          onPressed: () async {
                            double balanceD = double.parse(amount.text
                                    .substring(1, amount.text.length)) *
                                8.21;
                            print(widget.qr_data);
                            print(balanceD.toString());
                            await StellarHelper.sendPayment(
                                balanceD.toStringAsFixed(3), widget.qr_data!);

                            StellarHelper.getAccountBalance().then((val) =>
                                {_.read()<LoggedInStore>().setBalance(val)});
                            toastification.show(
                              context: context,
                              type: ToastificationType.success,
                              style: ToastificationStyle.flat,
                              title: const Text('Payment Successfull'),
                              description:
                                  Text("Sent ${amount.text} to ${widget.name}"),
                              alignment: Alignment.topLeft,
                              autoCloseDuration: const Duration(seconds: 4),
                            );
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          minWidth: double.infinity,
                          height: 50,
                          child: Text(
                            "Create Coin",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
