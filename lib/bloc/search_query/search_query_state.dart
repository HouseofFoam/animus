part of 'search_query_bloc.dart';

sealed class SearchQueryState extends Equatable {
  const SearchQueryState();

  @override
  List<Object> get props => [];
}

final class SearchQueryInitial extends SearchQueryState {
  final String searchQuery;

  const SearchQueryInitial({this.searchQuery = ""});

  @override
  List<Object> get props => [searchQuery];
}
