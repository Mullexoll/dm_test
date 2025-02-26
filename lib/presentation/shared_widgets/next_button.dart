import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  const NextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(154, 127, 255, 1),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              width: 3,
              color: Colors.white,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 12),
          child: Text(
            (context.watch<GameBloc>().state as GameLoaded).currentLevel == 10
                ? 'Завершити'
                : 'Далі',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
