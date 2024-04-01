import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_top_event.dart';
part 'anime_top_state.dart';

class AnimeTopBloc extends Bloc<AnimeTopEvent, AnimeTopState> {
  final AnimeListDataSource repository;
  AnimeTopBloc({required this.repository}) : super(AnimeTopInitial()) {
    on<LoadAnimeTop>((event, emit) async {
      try {
        emit(AnimeTopInitial());
        final response = await repository.getTopAnimes();
        emit(AnimeTopHasData(animeList: response));
      } catch (e) {
        emit(AnimeTopError(errorMassage: e.toString()));
      }
    });
  }
}
