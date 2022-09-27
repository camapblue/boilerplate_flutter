part of 'tabbar_icon.dart';

class BadgeNumber extends StatelessWidget {
  const BadgeNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BadgeNumberBloc, BadgeNumberState>(
      builder: (context, state) {
        return CircleNumber(
          color: AppColors.negative,
          height: 16,
          number: state.badgeNumber,
          numberStyle: context.labelSmall,
        );
      },
    );
  }
}
