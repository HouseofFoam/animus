part of 'page_pointer_bloc.dart';

sealed class PagePointerState extends Equatable {
  const PagePointerState();

  @override
  List<Object> get props => [];
}

final class PagePointerInitial extends PagePointerState {
  final int nowPage;
  // final String query;

  const PagePointerInitial({
    this.nowPage = 1,
  });

  @override
  List<Object> get props => [nowPage];
}
