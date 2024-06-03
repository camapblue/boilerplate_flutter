library common;

import 'logging/log.dart';
import 'logging/log_impl.dart';

export 'extension/color_extension.dart';
export 'extension/int_extension.dart';
export 'extension/string_extension.dart';
export 'extension/date_time_extension.dart';
export 'extension/object_extension.dart';
export 'extension/iterable_extension.dart';
export 'extension/num_extension.dart';

export 'animated/animated.dart';
export 'logging/log.dart';
export 'widgets/widgets.dart';

Log get log => LogImpl();