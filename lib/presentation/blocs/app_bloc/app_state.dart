part of 'app_bloc.dart';

@immutable
sealed class AppState extends Equatable {}

final class AppInitial extends AppState {
  @override
  List<Object?> get props => [];
}

final class AppLoading extends AppState {
  @override
  List<Object?> get props => [];
}

final class AppError extends AppState {
  final String message;

  AppError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class AppLoaded extends AppState {
  final List<Product> products;
  final String? error;

  AppLoaded({required this.products, this.error});

  @override
  List<Object?> get props => [products, error];
}
