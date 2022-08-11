import 'package:flutter/material.dart';
import 'package:walletx/pages/components/address_component.dart';
import 'package:walletx/pages/components/balance_component.dart';
import 'package:walletx/pages/components/transactions_component.dart';
import 'package:walletx/utils/colors.dart';
import 'package:walletx/utils/size_config.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: GlobalColors.polygonDarkColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.heightAdjusted(3),
                right: SizeConfig.heightAdjusted(3),
                bottom: SizeConfig.heightAdjusted(9),
                top: SizeConfig.heightAdjusted(15),
              ),
              child: Column(
                children: [
                  const AddressComponent(),
                  SizedBox(height: SizeConfig.heightAdjusted(10)),
                  const BalanceComponent()
                ],
              ),
            ),
          ),
          const TransactionsComponent()
        ],
      ),
    );
  }
}
