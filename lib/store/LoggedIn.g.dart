// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoggedIn.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoggedInStore on LoggedIn, Store {
  late final _$isloggedinAtom =
      Atom(name: 'LoggedIn.isloggedin', context: context);

  @override
  bool get isloggedin {
    _$isloggedinAtom.reportRead();
    return super.isloggedin;
  }

  @override
  set isloggedin(bool value) {
    _$isloggedinAtom.reportWrite(value, super.isloggedin, () {
      super.isloggedin = value;
    });
  }

  late final _$walletAtom = Atom(name: 'LoggedIn.wallet', context: context);

  @override
  Wallet? get wallet {
    _$walletAtom.reportRead();
    return super.wallet;
  }

  @override
  set wallet(Wallet? value) {
    _$walletAtom.reportWrite(value, super.wallet, () {
      super.wallet = value;
    });
  }

  late final _$balanceAtom = Atom(name: 'LoggedIn.balance', context: context);

  @override
  String get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(String value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  late final _$usersAtom = Atom(name: 'LoggedIn.users', context: context);

  @override
  ObservableList<dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$contactsAtom = Atom(name: 'LoggedIn.contacts', context: context);

  @override
  ObservableList<dynamic> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<dynamic> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$LoggedInActionController =
      ActionController(name: 'LoggedIn', context: context);

  @override
  void setIsLoggedIn(bool val) {
    final _$actionInfo =
        _$LoggedInActionController.startAction(name: 'LoggedIn.setIsLoggedIn');
    try {
      return super.setIsLoggedIn(val);
    } finally {
      _$LoggedInActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWallet(Wallet wlt) {
    final _$actionInfo =
        _$LoggedInActionController.startAction(name: 'LoggedIn.setWallet');
    try {
      return super.setWallet(wlt);
    } finally {
      _$LoggedInActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBalance(String val) {
    final _$actionInfo =
        _$LoggedInActionController.startAction(name: 'LoggedIn.setBalance');
    try {
      return super.setBalance(val);
    } finally {
      _$LoggedInActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsers(List<User> _users) {
    final _$actionInfo =
        _$LoggedInActionController.startAction(name: 'LoggedIn.setUsers');
    try {
      return super.setUsers(_users);
    } finally {
      _$LoggedInActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setContacts(List<Contact> _contacts) {
    final _$actionInfo =
        _$LoggedInActionController.startAction(name: 'LoggedIn.setContacts');
    try {
      return super.setContacts(_contacts);
    } finally {
      _$LoggedInActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isloggedin: ${isloggedin},
wallet: ${wallet},
balance: ${balance},
users: ${users},
contacts: ${contacts}
    ''';
  }
}
