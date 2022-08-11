
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletx/pages/wallet_page.dart';
import 'package:web3dart/web3dart.dart';

import '../models/transaction_model.dart';

var listenableSession = ValueNotifier<SessionStatus?>(null);
var listenableConnectionStatus =
    ValueNotifier('Connect to a Polygon wallet to use this service');
var listenableUri = ValueNotifier('');
var listenableTransactions = ValueNotifier<List<Transactions>>([]);
var listenableBal = ValueNotifier('0.0');
var listenableSignature = ValueNotifier('');
var listenableConnector = ValueNotifier<WalletConnect>(WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
        name: 'My App',
        description: 'An app for converting pictures to NFT',
        url: 'https://walletconnect.org',
        icons: [
          'https://files.gitbook.com/v0/b/'
              'gitbook-legacy-files/o/'
              'spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ])));


class EtherService {
  late Client _httpClient;
  late Web3Client _ethClient;
  bool data = false;

  final _endPoint =
      'https://polygon-mumbai.g.alchemy.com/v2/yGX6D3Chr52l2FIkF5YQ3THPPMVaWECk';


  void initClient(){
    _httpClient = Client();
    _ethClient = Web3Client(_endPoint, _httpClient);
    Future.delayed(const Duration(seconds: 5), () async {
      await getBalance();
    });
  }

  String truncateString({required text}) {
    int size = 4 + 2;

    if (text.toString().length > size) {
      String finalString =
          '${text.substring(0, 13)}...${text.substring(text.length - 2)}';
      return finalString;
    }
    return text;
  }

  loginUsingMetamask({required BuildContext context, required uri}) async {
    if (!listenableConnector.value.connected) {
      try {
        var session = await listenableConnector.value.createSession(
            onDisplayUri: (uri) async {
          listenableUri.value = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        print(session.chainId);
        listenableSession.value = session;

        if (session.chainId == 80001) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const WalletPage()));
          initClient();
        } else {
          listenableConnectionStatus.value =
              'Network not supported. Switch to Mumbai Testnet';
        }
      } catch (exp) {
        print(exp);
      }
    }
  }

  Future<void> getBalance() async {
    var balance = _ethClient.getBalance(
        EthereumAddress.fromHex(listenableSession.value!.accounts[0]));
    balance.then((value) => {
          listenableBal.value =
              (value.getInWei.toDouble() / pow(10, 18)).toStringAsFixed(3),
          print('Value ${value.getInWei}')
        });
  }

  getNetworkName(chainId) {
    switch (chainId) {
      case 1:
        return 'Ethereum Mainnet';
      case 3:
        return 'Ropsten Testnet';
      case 4:
        return 'Rinkeby Testnet';
      case 5:
        return 'Goreli Testnet';
      case 42:
        return 'Kovan Testnet';
      case 137:
        return 'Polygon Mainnet';
      case 80001:
        return 'Mumbai Testnet';
      default:
        return 'Unknown Chain';
    }
  }
}
