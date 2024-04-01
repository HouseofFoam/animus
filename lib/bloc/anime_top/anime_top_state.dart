part of 'anime_top_bloc.dart';

sealed class AnimeTopState extends Equatable {
  const AnimeTopState();

  @override
  List<Object> get props => [];
}

final class AnimeTopInitial extends AnimeTopState {}

final class AnimeTopHasData extends AnimeTopState {
  final AnimeList animeList;
  const AnimeTopHasData({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

final class AnimeTopError extends AnimeTopState {
  final String errorMassage;

  const AnimeTopError({required this.errorMassage});

  @override
  List<Object> get props => [errorMassage];
}
