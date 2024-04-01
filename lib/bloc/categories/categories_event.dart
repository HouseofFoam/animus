part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class PickCategory extends CategoriesEvent {}

class ChangeCategory extends CategoriesEvent {
  final int newIndex;

  const ChangeCategory({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}
