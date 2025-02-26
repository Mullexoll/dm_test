import 'package:bloc/bloc.dart';
import 'package:dayme_test/data/models/product.model.dart';
import 'package:dayme_test/data/repositories/product.repository.dart';
import 'package:dayme_test/domain/use-cases/get_products_from_repo.use-case.dart';
import 'package:dayme_test/domain/use-cases/send_game_result.use-case.dart';
import 'package:dayme_test/domain/use-cases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameInitialEvent>(_onGameInitialEvent);
    on<GameSelectProductEvent>(_onGameSelectProductEvent);
    on<GameNextLevelEvent>(_onGameNextLevelEvent);
    on<GameDeselectProductEvent>(_onGameDeselectProductEvent);
    on<GameEndGameEvent>(_onGameEndGameEvent);
  }

  void _onGameInitialEvent(
    GameInitialEvent event,
    Emitter<GameState> emit,
  ) {
    final List<Product> products = event.products;

    final List<Product> shuffledProducts = List.from(products);
    shuffledProducts.shuffle();

    emit(
      GameLoaded(
        products: shuffledProducts,
        selectedProducts: [],
        currentBonus: 0,
        currentLevel: 1,
      ),
    );
  }

  void _onGameSelectProductEvent(
    GameSelectProductEvent event,
    Emitter<GameState> emit,
  ) {
    final currentState = state as GameLoaded;
    List<int> selectedProducts = List<int>.from(currentState.selectedProducts);
    int newBonus = currentState.currentBonus;

    if (!selectedProducts.contains(event.selectedProductId)) {
      selectedProducts.add(event.selectedProductId);
      newBonus += 2;
    }

    if (selectedProducts.contains(event.secondProductId)) {
      selectedProducts.remove(event.secondProductId);
      newBonus -= 2;
    }

    emit(currentState.copyWith(
      selectedProducts: selectedProducts,
      currentBonus: newBonus,
    ));
  }

  void _onGameDeselectProductEvent(
    GameDeselectProductEvent event,
    Emitter<GameState> emit,
  ) {
    final currentState = state as GameLoaded;
    List<int> selectedProducts = List<int>.from(currentState.selectedProducts);
    int newBonus = currentState.currentBonus;

    selectedProducts.remove(event.productId);
    newBonus = currentState.currentBonus - 2;

    emit(currentState.copyWith(
      selectedProducts: selectedProducts,
      currentBonus: newBonus,
    ));
  }

  void _onGameNextLevelEvent(
    GameNextLevelEvent event,
    Emitter<GameState> emit,
  ) {
    final List<Product> products = List.from((state as GameLoaded).products);
    final List<int> selectedProductIds =
        List.from((state as GameLoaded).selectedProducts);

    products.removeWhere((product) => selectedProductIds.contains(product.id));

    final List<Product> shuffledProducts = List.from(products);
    shuffledProducts.shuffle();

    emit((state as GameLoaded).copyWith(
      products: shuffledProducts,
      currentLevel: (state as GameLoaded).currentLevel + 1,
    ));
  }

  void _onGameEndGameEvent(
    GameEndGameEvent event,
    Emitter<GameState> emit,
  ) async {
    final List<Product> products = await GetProductsFromRepoUseCase(
      productRepository: GetIt.instance<ProductRepository>(),
    ).call();

    final sendGameDataAPI = SendGameResultUseCase(
      selectedProducts: (state as GameLoaded).selectedProducts,
      currentBonus: (state as GameLoaded).currentBonus,
    );

    await sendGameDataAPI.call();

    if (sendGameDataAPI.runtimeType != Success) {
      emit(GameLoaded(
        products: products,
        selectedProducts: [],
        currentBonus: 0,
        currentLevel: 1,
      ));
    }

    emit(GameLoaded(
      products: products,
      selectedProducts: [],
      currentBonus: 0,
      currentLevel: 1,
    ));
  }
}
