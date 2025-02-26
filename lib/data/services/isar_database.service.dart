import 'package:dayme_test/data/models/product.model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

class IsarDatabaseService {
  late Isar isar;

  Future<void> initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        ProductSchema,
      ],
      name: 'ProductRepositoryIsarDB',
      directory: dir.path,
    );
  }

  Future<void> closeIsar() async {
    if (isar.isOpen) {
      await isar.close();
    }
  }
}

Future<void> setupIsarDBGetIt() async {
  final dbService = IsarDatabaseService();

  if (!getIt.isRegistered<IsarDatabaseService>()) {
    await dbService.initializeIsar();
    getIt.registerSingleton<IsarDatabaseService>(dbService);
  }
}

Future<void> logoutForIsar() async {
  final dbService = getIt<IsarDatabaseService>();

  await dbService.closeIsar();

  getIt.unregister<IsarDatabaseService>();
}
