// ignore_for_file: avoid_print

import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:localstorage/localstorage.dart';

class StellarHelper {
  static final StellarSDK sdk = StellarSDK.TESTNET;
  static Wallet? wallet;
  static KeyPair? keyPair0;
  static AccountResponse? accountData;

  static Future<Wallet?> getWallet() async {
    String? mnemonic = localStorage.getItem('mnemonic');

    if (mnemonic == null) {
      return null;
    }

    Wallet _wallet = await Wallet.from(mnemonic);
    wallet = _wallet;

    return _wallet;
  }

  static Future<Wallet> createWallet() async {
    String mnemonic = await Wallet.generate24WordsMnemonic();
    localStorage.setItem('mnemonic', mnemonic);

    Wallet _wallet = await Wallet.from(mnemonic);
    wallet = _wallet;

    return _wallet;
  }

  static Future<KeyPair> getKeyPair() async {
    if (wallet == null) {
      throw Exception('Generate wallet first');
    }

    KeyPair _keyPair0 = await wallet!.getKeyPair(index: 0);
    print("Key Pair - ${_keyPair0.toString()}");

    keyPair0 = _keyPair0;

    return _keyPair0;
  }

  static Future<bool> fundAccount() async {
    if (keyPair0 == null) {
      throw Exception('Generate KeyPair first');
    }

    bool funded = await FriendBot.fundTestAccount(keyPair0!.accountId);
    print("Funded Account: $funded");

    return funded;
  }

  static Future<AccountResponse> getAccountData() async {
    if (keyPair0 == null) {
      throw Exception('Generate KeyPair first');
    }

    String accountId = keyPair0!.accountId;
    AccountResponse _account = await sdk.accounts.account(accountId);
    accountData = _account;

    return _account;
  }

  static Future<String> getAccountBalance() async {
    if (accountData == null) {
      throw Exception('Get Account Data first');
    }

    for (Balance balance in accountData!.balances) {
      if (balance.assetType == Asset.TYPE_NATIVE) {
        return balance.balance;
      }
    }

    return "0";
  }

  static Future<List<OperationResponse>> getAccountPayments() async {
    if (accountData == null) {
      throw Exception('Get Account Data first');
    }

    Page<OperationResponse> payments = await sdk.payments
        .forAccount(accountData!.accountId)
        .order(RequestBuilderOrder.DESC)
        .execute();

    if (payments.records == null) return [];

    return payments.records!;
  }

  static Future<List<TransactionResponse>> getAccountTransactions() async {
    if (accountData == null) {
      throw Exception('Get Account Data first');
    }

    Page<TransactionResponse> payments = await sdk.transactions
        .forAccount(accountData!.accountId)
        .order(RequestBuilderOrder.DESC)
        .execute();

    if (payments.records == null) return [];

    return payments.records!;
  }
}
