part of 'page_total_bloc.dart';

sealed class PageTotalEvent extends Equatable {
  const PageTotalEvent();

  @override
  List<Object> get props => [];
}

class PageTotalChange extends PageTotalEvent {
  final int newPageTotal;

  const PageTotalChange({required this.newPageTotal});

  @override
  List<Object> get props => [newPageTotal];
}
