import 'package:boilerplate_flutter/constants/app_constants.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() {
    return _LandingScreenState();
  }
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Container(
        color: context.cardColor,
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            SizedBox(
              height: 120,
              child: Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(AppImagesAsset.appIcon),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              child: Center(
                child: XText.headlineSmall(
                  AppConstants.AppSologan,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  XLinkButton(
                    title: S.of(context).translate(Strings.Button.signIn),
                    onPressed: () {
                      AppRouting().pushReplacementNamed(Screens.logIn);
                    },
                  ),
                  const Spacer(),
                  XLinkButton(
                    title: S.of(context).translate(Strings.Button.tryAsGuest),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }
}
