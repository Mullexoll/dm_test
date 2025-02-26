part of 'game_bloc.dart';

sealed class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

final class GameInitialEvent extends GameEvent {
  final List<Product> products;

  const GameInitialEvent({required this.products});

  @override
  List<Object> get props => [products];
}

final class GameSelectProductEvent extends GameEvent {
  final int selectedProductId;
  final int secondProductId;
  final int currentLevel;

  const GameSelectProductEvent({
    required this.selectedProductId,
    required this.secondProductId,
    required this.currentLevel,
  });

  @override
  List<Object> get props => [
        selectedProductId,
        secondProductId,
        currentLevel,
      ];
}

final class GameNextLevelEvent extends GameEvent {
  const GameNextLevelEvent();
}

final class GameDeselectProductEvent extends GameEvent {
  final int productId;
  final int currentLevel;

  const GameDeselectProductEvent(
      {required this.productId, required this.currentLevel});

  @override
  List<Object> get props => [productId, currentLevel];
}

final class GameEndGameEvent extends GameEvent {
  const GameEndGameEvent();
}
