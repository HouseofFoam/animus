part of 'anime_list_bloc.dart';

sealed class AnimeListState extends Equatable {
  const AnimeListState();

  @override
  List<Object> get props => [];
}

final class AnimeListInitial extends AnimeListState {}

final class AnimeListHasData extends AnimeListState {
  final AnimeList animeList;
  const AnimeListHasData({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

final class AnimeListError extends AnimeListState {
  final String errorMassage;

  const AnimeListError({required this.errorMassage});

  @override
  List<Object> get props => [errorMassage];
}
