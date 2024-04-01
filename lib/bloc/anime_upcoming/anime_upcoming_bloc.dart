import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_upcoming_event.dart';
part 'anime_upcoming_state.dart';

class AnimeUpcomingBloc extends Bloc<AnimeUpcomingEvent, AnimeUpcomingState> {
  final AnimeListDataSource repository;
  AnimeUpcomingBloc({required this.repository})
      : super(AnimeUpcomingInitial()) {
    on<LoadAnimeUpcoming>((event, emit) async {
      try {
        emit(AnimeUpcomingInitial());
        final response = await repository.getSeasonAnimes(time: 'upcoming');
        emit(AnimeUpcomingHasData(animeList: response));
      } catch (e) {
        emit(AnimeUpcomingError(errorMassage: e.toString()));
      }
    });
  }
}
