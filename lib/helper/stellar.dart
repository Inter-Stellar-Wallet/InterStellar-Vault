import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:localstorage/localstorage.dart';

class StellarHelper {
  static final StellarSDK sdk = StellarSDK.TESTNET;
  static Wallet? wallet;

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
}
