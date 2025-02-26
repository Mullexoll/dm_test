import 'package:dayme_test/data/models/product.model.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

class ProductRepository {
  final IsarCollection<Product> _storage;
  final Isar _isar;

  ProductRepository(this._isar) : _storage = _isar.collection<Product>();

  Future<bool> addToRepository({
    required Product product,
  }) async {
    try {
      await _isar.writeTxn(
        () async => await _storage.put(product),
      );

      return true;
    } catch (e, s) {
      debugPrint('$e $s');

      return false;
    }
  }

  Future<bool> saveProducts(List<Product> products) async {
    try {
      await _isar.writeTxn(() async {
        for (var product in products) {
          final existingProduct = await _storage.get(product.productId);
          if (existingProduct == null) {
            await _storage.put(product);
          }
        }
      });
      return true;
    } catch (e, s) {
      debugPrint('$e $s');
      return false;
    }
  }

  Future<List<Product>> getAllProducts() async {
    final List<Product> foundProducts = await _storage.where().findAll();

    return foundProducts;
  }

  Future<void> deleteProductByProductId(int productId) async {
    await _isar.writeTxn(() async {
      final product =
          await _storage.filter().productIdEqualTo(productId).findFirst();
      if (product != null) {
        await _storage.delete(product.id);
      }
    });
  }
}
