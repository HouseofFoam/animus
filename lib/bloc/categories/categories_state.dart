part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesHasData extends CategoriesState {
  final AnimeList animeList;
  const CategoriesHasData({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

final class CategoriesError extends CategoriesState {
  final String errString;
  const CategoriesError({required this.errString});

  @override
  List<Object> get props => [errString];
}
