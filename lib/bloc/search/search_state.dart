part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchHasData extends SearchState {
  final AnimeList animeList;
  const SearchHasData({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

final class SearchError extends SearchState {
  final String errorMassage;

  const SearchError({required this.errorMassage});

  @override
  List<Object> get props => [errorMassage];
}
