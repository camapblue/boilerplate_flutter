import 'package:bloc/bloc.dart';
import 'package:common/common.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    log.trace('\n ---- ${bloc.toString()}: $event ----');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.trace(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.error('\n ---- ${bloc.toString()}: $error ----');
    super.onError(bloc, error, stackTrace);
  }
}