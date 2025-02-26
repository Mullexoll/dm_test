import 'package:dayme_test/core/exceptions/data_operation.exception.dart';
import 'package:dayme_test/data/datasource/get_all_products.api.dart';
import 'package:dayme_test/data/models/product.model.dart';
import 'package:dayme_test/domain/use-cases/usecase.dart';

class GetProductsUseCase extends UseCase<List<Product>> {
  @override
  Future<List<Product>> call() async {
    final products = await GetAllProductsAPI().getAllProducts();

    if (products is DataFailure) {
      throw Exception(products.message);
    }

    return products as List<Product>;
  }
}
