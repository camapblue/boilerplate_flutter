import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:common/core/core.dart';

mixin MessageShowing {
  void showFailureMessage(String messageKey,
      {List<dynamic> params = const []}) {
    EventBus().event<ShowMessageBloc>(
      Keys.Blocs.showMessageBloc,
      WarningMessageShowed(
        messageKey,
        params: params,
      ),
    );
  }

  void showSuccessMessage(String messageKey,
      {List<dynamic> params = const []}) {
    EventBus().event<ShowMessageBloc>(
      Keys.Blocs.showMessageBloc,
      WarningMessageShowed(
        messageKey,
        params: params,
        isSuccess: true,
      ),
    );
  }
}