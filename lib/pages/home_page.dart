import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:interstellar/helper/stellar.dart';
import 'package:interstellar/pages/contact.dart';
import 'package:interstellar/pages/my_qr.dart';
import 'package:interstellar/scanner/mobile_scanner_overlay.dart';
import 'package:interstellar/store/LoggedIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

final db = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  String phone = "";
  String email = "";
  List<Map<String, dynamic>> txList = [];

  void _getAllUsers() async {
    final _users = List<User>.empty(growable: true);

    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        _users.add(User.fromMap(doc.data()));
      }
    });

    print(_users.length);

    context.read<LoggedInStore>().setUsers(_users);
    await _getDetails();
  }

  final List<dynamic> _services = [
    ['Transfer', Iconsax.export_1, Colors.blue],
    ['Scanner', Icons.qr_code_scanner_outlined, Colors.green],
    ['Top-up', Iconsax.import, Colors.pink],
    ['Bill', Iconsax.wallet_3, Colors.orange],
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    _getAllUsers();
    getTxnData();
    super.initState();
  }

  User? findUser(accountId) {
    final users = context.read<LoggedInStore>().users;

    for (var user in users) {
      if (user.accountId == accountId) {
        return user;
      }
    }

    return null;
  }

  Future<void> _getDetails() async {
    final users = context.read<LoggedInStore>().users;
    await StellarHelper.getAccountData();
    final accountId = StellarHelper.accountData!.accountId;

    for (var user in users) {
      if (user.accountId == accountId) {
        setState(() {
          phone = user.phone;
          email = user.email;
        });
      }
    }
  }

  getTxnData() async {
    await StellarHelper.getWallet();
    await StellarHelper.getKeyPair();
    await StellarHelper.getAccountData();
    final txns = await StellarHelper.getAccountTransactions();

    print(txns.length);

    List<Map<String, dynamic>> _txList = txns.map((txn) {
      final user = findUser(txn.sourceAccount);
      String name = (user?.email) ?? (txn.hash.substring(0, 12) + "...");

      return {
        'createdAt': format(DateTime.parse(txn.createdAt)),
        'name': name,
        'successful': txn.successful,
        'amount': txn.feeCharged.toString(),
        'avatar':
            "https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png",
      };
    }).toList();

    setState(() {
      txList = _txList;
    });
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.grey.shade900,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: const Offset(-20.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 80.0,
                    height: 80.0,
                    margin: const EdgeInsets.only(
                      left: 20,
                      top: 24.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/images/avatar-1.png')),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    email,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Divider(
                  color: Colors.grey.shade800,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.home),
                  title: const Text('Dashboard'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.chart_2),
                  title: const Text('Analytics'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.profile_2user),
                  title: const Text('Contacts'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Divider(color: Colors.grey.shade800),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.setting_2),
                  title: const Text('Settings'),
                ),
                Observer(builder: (_) {
                  return ListTile(
                    onTap: () {
                      localStorage.removeItem('mnemonic');
                      _.read<LoggedInStore>().setIsLoggedIn(false);
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                  );
                }),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.support),
                  title: const Text('Support'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      child: Observer(builder: (_) {
        return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: RefreshIndicator(
                onRefresh: () async {
                  print("pulled");

                  StellarHelper.getAccountData().then((val) {
                    StellarHelper.getAccountBalance().then((val) =>
                        {print(val), _.read<LoggedInStore>().setBalance(val)});
                  });
                },
                child:
                    CustomScrollView(controller: _scrollController, slivers: [
                  SliverAppBar(
                    expandedHeight: 250.0,
                    elevation: 0,
                    pinned: true,
                    stretch: true,
                    toolbarHeight: 80,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      color: Colors.black,
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              value.visible
                                  ? Iconsax.close_square
                                  : Iconsax.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Iconsax.notification,
                            color: Colors.grey.shade700),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.qr_code, color: Colors.grey.shade700),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyQrCode()));
                        },
                      ),
                    ],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    centerTitle: true,
                    title: AnimatedOpacity(
                      opacity: _isScrolled ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Observer(builder: (_) {
                            return Text(
                              'XLM ${_.watch<LoggedInStore>().balance}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 30,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      titlePadding: const EdgeInsets.only(left: 20, right: 20),
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: _isScrolled ? 0.0 : 1.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FadeIn(
                              duration: const Duration(milliseconds: 500),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'XLM',
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Observer(builder: (_) {
                                    return Text(
                                      _.watch<LoggedInStore>().balance,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeIn(
                              duration: const Duration(milliseconds: 500),
                              child: MaterialButton(
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                onPressed: () {},
                                child: const Text(
                                  'Add Money',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                color: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 12),
                      height: 115,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _services.length,
                        itemBuilder: (context, index) {
                          return FadeInDown(
                            duration: Duration(milliseconds: (index + 1) * 100),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                onTap: () {
                                  if (_services[index][0] == 'Transfer') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ContactPage()));
                                  }
                                  if (_services[index][0] == 'Scanner') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BarcodeScannerWithOverlay()));
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade900,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          _services[index][1],
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _services[index][0],
                                      style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ])),
                  SliverFillRemaining(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: Column(
                        children: [
                          FadeInDown(
                            duration: const Duration(milliseconds: 500),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Observer(builder: (_) {
                                    return Text(
                                        'XLM ${_.watch<LoggedInStore>().balance}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ));
                                  }),
                                ]),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 20),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: txList.length,
                              itemBuilder: (context, index) {
                                return FadeInDown(
                                  duration: const Duration(milliseconds: 500),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              txList[index]['avatar'],
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  txList[index]['name'],
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade900,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  txList[index]['createdAt'],
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "XLM" + txList[index]['amount'],
                                          style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ])));
      }),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
