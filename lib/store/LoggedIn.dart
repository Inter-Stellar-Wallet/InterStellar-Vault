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

}
