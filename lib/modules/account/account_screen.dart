import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:common/core/core.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const XText.displayMedium('Account'),
          const SizedBox(
            height: 24,
          ),
          XLinkButton(
            title: 'Log Out',
            onPressed: () {
              EventBus().event<SessionBloc>(
                Keys.Blocs.sessionBloc,
                SessionUserSignedOut(),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
