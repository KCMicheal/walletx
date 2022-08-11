import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walletx/utils/assets.dart';
import 'package:walletx/utils/colors.dart';
import 'package:walletx/utils/ether_service.dart';
import 'package:walletx/utils/multi_value_listenable.dart';
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
    // listenableConnector.value.on('connect', (session) => listenableSession.value = session);
    // listenableConnector.value.on('disconnect', (payload) => listenableSession.value = null);
    // listenableConnector.value.on('session_update', (payload) {
    //   listenableSession.value = payload as SessionStatus?;
    //   print(listenableSession.value!.accounts[0]);
    //   print(listenableSession.value!.chainId);
    // });

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
                                child: Text('Connect with walletx',
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
