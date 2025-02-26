part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

final class AppInitialEvent extends AppEvent {}

final class AppGetProductsEvent extends AppEvent {}
