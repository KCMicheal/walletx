import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walletx/models/transaction_model.dart';
import 'package:walletx/utils/colors.dart';
import 'package:walletx/utils/size_config.dart';
import 'package:walletx/utils/text_styles.dart';

class TransactionDetailsSheetIos extends StatelessWidget {
  const TransactionDetailsSheetIos({Key? key, required this.transaction})
      : super(key: key);

  final Transactions transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.heightAdjusted(3),
                vertical: SizeConfig.heightAdjusted(3)),
            width: double.infinity,
            color: GlobalColors.polygonLightColor,
            child: Text('Trannsaction Details',
                style: GlobalTextStyles.medium(color: GlobalColors.white)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.heightAdjusted(3),
                vertical: SizeConfig.heightAdjusted(3)),
            child: Column(
              children: [
                TransactionItem(
                    title: 'Transaction Hash', content: transaction.hash),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status',
                            style: GlobalTextStyles.medium(
                                color: GlobalColors.black, fontSize: 13)),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.heightAdjusted(2),
                                vertical: SizeConfig.heightAdjusted(1)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: transaction.isError == '0'
                                    ? GlobalColors.green.withAlpha(100)
                                    : Colors.red.withAlpha(100)),
                            child: transaction.isError == '0'
                                ? Text('Success',
                                    style: GlobalTextStyles.regularText(
                                        fontSize: 12,
                                        color: GlobalColors.green))
                                : Text('Failed',
                                    style: GlobalTextStyles.regularText(
                                        fontSize: 12, color: Colors.red))),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightAdjusted(1)),
                    Divider(),
                    SizedBox(height: SizeConfig.heightAdjusted(1))
                  ],
                ),
                TransactionItem(title: 'From', content: transaction.from),
                TransactionItem(title: 'To', content: transaction.to),
                TransactionItem(
                    title: 'Transaction Block',
                    content: transaction.blockNumber),
                TransactionItem(title: 'Time', content: transaction.timeStamp),
                TransactionItem(title: 'Gas', content: '${transaction.gas} (MATIC)'),
                TransactionItem(title: 'Amount sent', content: '${transaction.value} (MATIC)'),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GlobalTextStyles.medium(
                color: GlobalColors.black, fontSize: 13)),
        Text(content),
        Divider(),
        SizedBox(height: SizeConfig.heightAdjusted(1))
      ],
    );
  }
}
