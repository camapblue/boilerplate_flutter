import 'package:boilerplate_flutter/constants/constants.dart';
import 'package:boilerplate_flutter/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boilerplate_flutter/blocs/blocs.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderBloc, LoaderState>(
      builder: (context, state) {
        return Visibility(
          visible: state is LoaderRunSuccess,
          child: Container(
            color: Colors.green.withOpacity(0.78),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: context.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${S.of(context).translate(
                          state.loadingMessage ?? Strings.Common.loading,
                        )}...',
                    style:
                        context.bodyMedium?.copyWith(
                              color: AppColors.white,
                            ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
