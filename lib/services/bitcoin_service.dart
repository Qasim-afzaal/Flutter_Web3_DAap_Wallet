import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';

class BinanceSmartChainService implements BlockchainService {
  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    return HEX.encode(master.key);
  }

  @override
  Future<String> getPublicKey(String privateKey) async {
    final ethKey = EthPrivateKey.fromHex(privateKey);
    final address = await ethKey.address;
    return address.hexEip55;
  }

  @override
  Future<String> getAddressBalance(String address) async {
    final client = Web3Client('<Your BSC Node URL>', Client());
    final balance = await client.getBalance(EthereumAddress.fromHex(address));
    return balance.getValueInUnit(EtherUnit.ether).toString();
  }
}
