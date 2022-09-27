import 'package:boilerplate_flutter/blocs/blocs.dart';
import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'badge_number.dart';

class TabbarIcon extends StatelessWidget {
  final BadgeType? badgeType;
  final Widget icon;

  const TabbarIcon({
    super.key, 
    required this.icon,
    this.badgeType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 26,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Center(child: icon),
          if (badgeType != null)
            Positioned(
              right: 0,
              top: -3,
              child: BlocProvider<BadgeNumberBloc>(
                create: (_) => BadgeNumberBloc.instance(badgeType!),
                child: const BadgeNumber(),
              ),
            )
        ],
      ),
    );
  }
}
