import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:dayme_test/core/constants/game_constants.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:dayme_test/presentation/shared_widgets/close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Row(
          children: [
            CloseActionButton(
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Spacer(),
            Text(
              '${GameConstants.maxBonus} / ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Color.fromRGBO(86, 65, 191, 1),
                  ),
            ),
            Text(
              '${(state as GameLoaded).currentBonus}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gap(10),
            SvgPicture.asset(
              AppAssets.activeCoinIcon,
              width: 36,
              height: 36,
            ),
          ],
        );
      },
    );
  }
}
