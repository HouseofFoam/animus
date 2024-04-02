part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class PickCategory extends CategoriesEvent {}

class ChangeCategory extends CategoriesEvent {
  final String newString;
  final int newPage;

  const ChangeCategory({required this.newString, this.newPage = 1});

  @override
  List<Object> get props => [newString, newPage];
}
