import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boilerplate_flutter/blocs/blocs.dart';

class LostConnection extends StatelessWidget {
  const LostConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        log.error('Lost Connection !');
        return Visibility(
          visible: !state.isConnected,
          child: Container(
            color: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                S.of(context).translate(
                      Strings.Common.noInternetConnection,
                    ),
                style: context.headlineSmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
