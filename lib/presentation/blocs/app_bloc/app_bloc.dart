import 'package:bloc/bloc.dart';
import 'package:dayme_test/data/models/product.model.dart';
import 'package:dayme_test/data/repositories/product.repository.dart';
import 'package:dayme_test/data/services/isar_database.service.dart';
import 'package:dayme_test/domain/use-cases/get_products.use-case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<AppInitialEvent>(_onAppInitialEvent);
    on<AppGetProductsEvent>(_onAppGetProductsEvent);
  }

  void _onAppInitialEvent(AppInitialEvent event, Emitter<AppState> emit) async {
    emit(AppLoading());
    await setupIsarDBGetIt();

    add(AppGetProductsEvent());
  }

  void _onAppGetProductsEvent(
    AppGetProductsEvent event,
    Emitter<AppState> emit,
  ) async {
    String error = '';
    final isar = getIt<IsarDatabaseService>().isar;
    final ProductRepository productRepository = ProductRepository(isar);
    if (!GetIt.instance.isRegistered<ProductRepository>()) {
      GetIt.instance.registerSingleton<ProductRepository>(productRepository);
    }
    final products = await productRepository.getAllProducts();
    await productRepository.saveProducts(products);

    try {
      final List<Product> getProductsUseCase =
          await GetProductsUseCase().call();
      await productRepository.saveProducts(getProductsUseCase);

      emit(AppLoaded(products: getProductsUseCase));
    } catch (e) {
      debugPrint(e.toString());
      error = e.toString();
    }

    emit(AppLoaded(products: products, error: error));
  }
}
