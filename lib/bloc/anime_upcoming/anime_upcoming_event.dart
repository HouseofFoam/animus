part of 'anime_upcoming_bloc.dart';

sealed class AnimeUpcomingEvent extends Equatable {
  const AnimeUpcomingEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimeUpcoming extends AnimeUpcomingEvent {}
