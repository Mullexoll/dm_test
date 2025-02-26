import 'package:dayme_test/config/theme_extension.dart';
import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:dayme_test/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:dayme_test/presentation/screens/game_screen/game_screen.dart';
import 'package:dayme_test/presentation/screens/home_screen/widgets/home_screen_cards_widget.dart';
import 'package:dayme_test/presentation/shared_widgets/app_button.dart';
import 'package:dayme_test/presentation/shared_widgets/close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CloseActionButton(
              onTap: () {},
            ),
            Spacer(),
            Center(
              child: SvgPicture.asset(
                AppAssets.homeScreenText,
                width: 284,
                height: 154,
              ),
            ),
            Gap(10),
            HomeScreenCardsWidget(),
            Spacer(),
            BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                return BlocListener<AppBloc, AppState>(
                  listenWhen: (previous, current) => current is AppLoaded,
                  listener: (context, appState) {
                    if (appState is AppLoaded) {
                      context
                          .read<GameBloc>()
                          .add(GameInitialEvent(products: appState.products));
                    }
                  },
                  child: BlocBuilder<AppBloc, AppState>(
                    builder: (_, appState) {
                      if (appState is AppInitial || appState is AppLoading) {
                        return Center(
                          child: Text(
                            'завантаження...',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Color.fromRGBO(188, 147, 255, 1),
                                ),
                          ),
                        );
                      }
                      if (appState is AppLoaded && appState.error != null) {
                        return Center(
                          child: Text(
                            appState.error ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.red.shade300,
                                ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                );
              },
            ),
            Gap(24),
            AppButton.start(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameScreen(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
