part of 'anime_top_bloc.dart';

sealed class AnimeTopEvent extends Equatable {
  const AnimeTopEvent();

  @override
  List<Object> get props => [];
}

class LoadAnimeTop extends AnimeTopEvent {}
