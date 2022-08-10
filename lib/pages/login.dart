import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metamask/utils/assets.dart';
import 'package:metamask/utils/colors.dart';
import 'package:metamask/utils/ether_service.dart';
import 'package:metamask/utils/multi_value_listenable.dart';
import 'package:slider_button/slider_button.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String uri;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: listenableUri,
        builder: (context, String value, child) {
          uri = value;
          return Scaffold(
            backgroundColor: GlobalColors.polygonDarkColor,
            body: Padding(
              padding: const EdgeInsets.only(top: 190),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset(GlobalAssets.polygonLogo,
                              height: 60, fit: BoxFit.fitHeight),
                          const SizedBox(height: 150),
                          GestureDetector(
                            onTap: () => EtherService()
                                .loginUsingMetamask(context: context, uri: uri),
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Text('Connect with Metamask',
                                    style: TextStyle(
                                        color: GlobalColors.polygonDarkColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ],
                      ),
                    ),
                    Text('Connect to a Polygon wallet to use this service',
                        style: TextStyle(color: GlobalColors.white.withAlpha(150))),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
