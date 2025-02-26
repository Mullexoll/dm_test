import 'package:dayme_test/config/theme_extension.dart';
import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:dayme_test/presentation/screens/game_screen/widgets/header_widget.dart';
import 'package:dayme_test/presentation/screens/home_screen/home.screen.dart';
import 'package:dayme_test/presentation/shared_widgets/collect_coins_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EndGameScreen extends StatelessWidget {
  const EndGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientTheme = Theme.of(context).extension<GradientTheme>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: gradientTheme?.backgroundGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HeaderWidget(),
            Gap(28),
            Spacer(),
            Text(
              'Вітаємо!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              'Твій виграш',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Center(
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.winIcon,
                      width: 297,
                      height: 297,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  child: Container(
                    width: 112,
                    height: 40,
                    padding: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(66),
                    ),
                    child: Text(
                      '${(context.watch<GameBloc>().state as GameLoaded).currentBonus} бонусів',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            Gap(28),
            Spacer(),
            CollectCoinsButton(
              text: 'Забрати бонуси',
              onPressed: () {
                context.read<GameBloc>().add(GameEndGameEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
