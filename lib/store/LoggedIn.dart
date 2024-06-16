import 'package:mobx/mobx.dart';
part 'LoggedIn.g.dart';


class LoggedInStore = LoggedIn with _$LoggedInStore;

abstract class LoggedIn with Store{

  @observable
  bool isloggedin = true;

  @action 
  void setIsLoggedIn(bool val) {
    isloggedin = val;
  }
}