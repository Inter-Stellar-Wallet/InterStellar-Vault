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
  String toString() {
    return '''
      isloggedin: ${isloggedin}
    ''';
  }
}
