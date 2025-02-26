import 'package:equatable/equatable.dart';

abstract class UseCase<Type> {
  Future<Type> call();
}

class Success extends Equatable {
  @override
  List<Object> get props => [];
}
