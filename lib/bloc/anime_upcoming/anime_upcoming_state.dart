part of 'anime_upcoming_bloc.dart';

sealed class AnimeUpcomingState extends Equatable {
  const AnimeUpcomingState();

  @override
  List<Object> get props => [];
}

final class AnimeUpcomingInitial extends AnimeUpcomingState {}

final class AnimeUpcomingHasData extends AnimeUpcomingState {
  final AnimeList animeList;
  const AnimeUpcomingHasData({required this.animeList});

  @override
  List<Object> get props => [animeList];
}

final class AnimeUpcomingError extends AnimeUpcomingState {
  final String errorMassage;

  const AnimeUpcomingError({required this.errorMassage});

  @override
  List<Object> get props => [errorMassage];
}
