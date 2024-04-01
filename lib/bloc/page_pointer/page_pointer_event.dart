part of 'page_pointer_bloc.dart';

sealed class PagePointerEvent extends Equatable {
  const PagePointerEvent();

  @override
  List<Object> get props => [];
}

class ChangePagePointer extends PagePointerEvent {
  final int changedNewPointer;

  const ChangePagePointer({required this.changedNewPointer});

  @override
  List<Object> get props => [changedNewPointer];
}
