import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:walletx/utils/assets.dart';
import 'package:walletx/utils/colors.dart';
import 'package:walletx/utils/ether_service.dart';
import 'package:walletx/utils/multi_value_listenable.dart';
import 'package:walletx/utils/size_config.dart';
import 'package:walletx/utils/text_styles.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class AddressComponent extends StatelessWidget {
  const AddressComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
        valueListenables: [listenableSession],
        builder: (context, value, child) {
          SessionStatus session = value[0];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.heightAdjusted(1)),
                decoration: BoxDecoration(
                    color: GlobalColors.greenAccent,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(GlobalAssets.profileIcon,
                        color: GlobalColors.polygonDarkColor, height: 35),
                    SizedBox(width: SizeConfig.widthAdjusted(1.5)),
                    session.accounts[0].length > 1
                        ? Text(
                            '${session.accounts[0].substring(0, 4)}'
                            '...${session.accounts[0].substring(session.accounts[0].length - 4)}',
                            style: GlobalTextStyles.medium(
                                fontSize: 12, color: GlobalColors.polygonDarkColor))
                        : Text('0',
                            style: GlobalTextStyles.medium(
                                fontSize: 12,
                                color: GlobalColors.polygonDarkColor)),
                    SizedBox(width: SizeConfig.widthAdjusted(1.5)),
                  ],
                ),
              )
            ],
          );
        });
  }
}
