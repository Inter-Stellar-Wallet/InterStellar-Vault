import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mobx/mobx.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
part 'LoggedIn.g.dart';

class LoggedInStore = LoggedIn with _$LoggedInStore;

abstract class LoggedIn with Store {
  @observable
  bool isloggedin = true;

  @observable
  Wallet? wallet;

  @observable
  String balance = "0";

  @observable
  ObservableList users = ObservableList<User>();

  @observable
  ObservableList contacts = ObservableList<Contact>();

  @action
  void setIsLoggedIn(bool val) {
    isloggedin = val;
  }

  @action
  void setWallet(Wallet wlt) {
    wallet = wlt;
  }

  @action
  void setBalance(String val) {
    balance = val;
  }

  @action
  void setUsers(List<User> _users) {
    print(_users.length);
    users = ObservableList.of(_users);
  }

  @action
  void setContacts(List<Contact> _contacts) {
    print(_contacts.length);
    users = ObservableList.of(_contacts);
  }
}

class User {
  final String email;
  final String phone;
  final String accountId;

  User({required this.email, required this.phone, required this.accountId});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      phone: map['phone'],
      accountId: map['accountId'],
    );
  }
}
