import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walletx/utils/colors.dart';
import 'package:walletx/utils/ether_service.dart';
import 'package:walletx/utils/size_config.dart';
import 'package:walletx/utils/text_styles.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BalanceComponent extends StatefulWidget {
  const BalanceComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<BalanceComponent> createState() => _BalanceComponentState();
}

class _BalanceComponentState extends State<BalanceComponent> {
  var usdBalance = '0.0';
  late WebSocketChannel channel;

  @override
  void initState() {
    channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.coincap.io/prices?assets=polygon'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: listenableBal,
        builder: (context, String value, child) {
          String walletBal = value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(walletBal,
                      style: GlobalTextStyles.medium(
                          fontSize: 20,
                          color: GlobalColors.white)),
                  Text('MATIC ',
                      style: GlobalTextStyles.medium(
                          fontSize: 14,
                          color: GlobalColors.washedWhite))
                ],
              ),
              SizedBox(width: SizeConfig.heightAdjusted(3)),
              Container(
                  height: 40,
                  width: 1,
                  color: GlobalColors.washedWhite),
              SizedBox(width: SizeConfig.heightAdjusted(3)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(r'$',
                      style: GlobalTextStyles.medium(
                          fontSize: 12,
                          color: GlobalColors.washedWhite)),
                  StreamBuilder(
                      stream: channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var jsonBody =
                          jsonDecode(snapshot.data as String);
                          var ethereumPrice = double.tryParse(
                              jsonBody['polygon']);
                          usdBalance = (ethereumPrice! *
                              double.tryParse(walletBal)!)
                              .toStringAsFixed(3);
                        }
                        return Text(usdBalance,
                            style: GlobalTextStyles.medium(
                                fontSize: 25,
                                color: GlobalColors.white));
                      })
                ],
              ),
            ],
          );
        });
  }
}
