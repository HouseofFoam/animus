part of 'anime_list_bloc.dart';

sealed class AnimeListEvent extends Equatable {
  const AnimeListEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimeList extends AnimeListEvent {}
