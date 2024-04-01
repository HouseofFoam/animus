part of 'page_total_bloc.dart';

sealed class PageTotalState extends Equatable {
  const PageTotalState();

  @override
  List<Object> get props => [];
}

final class PageTotalHasData extends PageTotalState {
  final int totalPage;

  const PageTotalHasData({this.totalPage = 1});

  @override
  List<Object> get props => [totalPage];
}

final class PageTotalNoData extends PageTotalState {}
