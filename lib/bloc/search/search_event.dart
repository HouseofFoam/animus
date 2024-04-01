part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimeList extends SearchEvent {}

class SearchAnime extends SearchEvent {
  final String query;
  final String genres;
  final int page;

  const SearchAnime({this.query = "", this.genres = "", required this.page});

  @override
  List<Object> get props => [query, genres];
}
