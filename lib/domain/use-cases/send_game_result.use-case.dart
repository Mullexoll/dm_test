import 'package:dayme_test/core/exceptions/data_operation.exception.dart';
import 'package:dayme_test/data/datasource/send_game_data.api.dart';
import 'package:dayme_test/domain/use-cases/usecase.dart';

class SendGameResultUseCase extends UseCase<void> {
  final List<int> selectedProducts;
  final int currentBonus;

  SendGameResultUseCase({
    required this.selectedProducts,
    required this.currentBonus,
  });

  @override
  Future<void> call() async {
    final gameResult = await SendGameDataAPI().sendGameData(
      selectedProducts,
      currentBonus,
    );

    if (gameResult is DataFailure) {
      throw Exception(gameResult.message);
    }
  }
}
