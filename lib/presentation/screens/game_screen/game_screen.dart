import 'package:dayme_test/config/theme_extension.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:dayme_test/presentation/screens/end_game_screen/end_game.screen.dart';
import 'package:dayme_test/presentation/screens/game_screen/widgets/current_level.dart';
import 'package:dayme_test/presentation/screens/game_screen/widgets/header_widget.dart';
import 'package:dayme_test/presentation/screens/game_screen/widgets/product_cards.dart';
import 'package:dayme_test/presentation/screens/game_screen/widgets/or_widget.dart';
import 'package:dayme_test/presentation/shared_widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientTheme = Theme.of(context).extension<GradientTheme>();

    return Scaffold(
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: gradientTheme?.backgroundGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(),
                  Gap(28),
                  CurrentLevel(key: UniqueKey()),
                  Gap(24),
                  Spacer(),
                  Center(
                    child: Text(
                      'А що обереш ти?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Gap(24),
                  Stack(
                    children: [
                      ProductCards(
                        key: ValueKey(state.currentLevel),
                        products: state.products,
                        currentLevel: state.currentLevel,
                      ),
                      Positioned.fill(
                        child: Center(
                          child: OrWidget(),
                        ),
                      ),
                    ],
                  ),
                  Gap(24),
                  Spacer(),
                  NextButton(
                    onPressed: () {
                      if (state.currentLevel == 10) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndGameScreen(),
                          ),
                        );
                      } else {
                        BlocProvider.of<GameBloc>(context).add(
                          GameNextLevelEvent(),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
