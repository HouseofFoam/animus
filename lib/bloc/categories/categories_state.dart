part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesIndex extends CategoriesState {
  final int index;
  const CategoriesIndex({this.index = 0});

  @override
  List<Object> get props => [index];
}
