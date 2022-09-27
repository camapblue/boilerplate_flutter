import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:common/core/core.dart';

mixin SessionData {
  bool get isGuest =>
      EventBus()
          .blocFromKey<SessionBloc>(Keys.Blocs.sessionBloc)
          ?.state
          .loggedInUser ==
      null;
}
