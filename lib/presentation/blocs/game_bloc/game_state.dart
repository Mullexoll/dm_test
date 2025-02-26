part of 'game_bloc.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}

final class GameLoaded extends GameState {
  final List<Product> products;
  final List<int> selectedProducts;
  final int currentBonus;
  final int currentLevel;

  const GameLoaded({
    required this.products,
    required this.selectedProducts,
    required this.currentBonus,
    required this.currentLevel,
  });

  GameLoaded copyWith({
    List<Product>? products,
    List<int>? selectedProducts,
    int? currentBonus,
    int? currentLevel,
  }) {
    return GameLoaded(
      products: products ?? this.products,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      currentBonus: currentBonus ?? this.currentBonus,
      currentLevel: currentLevel ?? this.currentLevel,
    );
  }

  @override
  List<Object> get props => [
        products,
        selectedProducts,
        currentBonus,
        currentLevel,
      ];
}
