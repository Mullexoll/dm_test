import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CurrentLevel extends StatelessWidget {
  const CurrentLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(10, (int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: index <
                  (context.read<GameBloc>().state as GameLoaded).currentLevel
              ? SvgPicture.asset(
                  AppAssets.progressElement,
                  width: 30.0,
                  height: 12,
                )
              : SvgPicture.asset(
                  AppAssets.progressInactiveElement,
                  width: 30.0,
                  height: 8,
                ),
        );
      }),
    );
  }
}
