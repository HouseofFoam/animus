import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'anime_list_event.dart';
part 'anime_list_state.dart';

class AnimeListBloc extends Bloc<AnimeListEvent, AnimeListState> {
  final AnimeListDataSource repository;
  AnimeListBloc({required this.repository}) : super(AnimeListInitial()) {
    on<LoadAnimeList>((event, emit) async {
      emit(AnimeListInitial());
      try {
        final response = await repository.getSeasonAnimes(time: 'now');
        emit(AnimeListHasData(animeList: response));
      } catch (e) {
        emit(AnimeListError(errorMassage: e.toString()));
      }
    });
  }
}
