import 'package:dayme_test/data/models/product.model.dart';
import 'package:dayme_test/data/repositories/product.repository.dart';

class GetProductsFromRepoUseCase {
  final ProductRepository productRepository;

  GetProductsFromRepoUseCase({required this.productRepository});

  Future<List<Product>> call() async {
    return await productRepository.getAllProducts();
  }
}
