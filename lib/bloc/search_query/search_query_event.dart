part of 'search_query_bloc.dart';

sealed class SearchQueryEvent extends Equatable {
  const SearchQueryEvent();

  @override
  List<Object> get props => [];
}

class ChangeQuery extends SearchQueryEvent {
  final String newQuery;

  const ChangeQuery({required this.newQuery});

  @override
  List<Object> get props => [newQuery];
}
