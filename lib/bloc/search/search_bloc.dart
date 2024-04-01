import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final AnimeListDataSource repository;
  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<LoadAnimeList>((event, emit) async {
      emit(SearchInitial());
      try {
        final response = await repository.getAnimeSearch();
        emit(SearchHasData(animeList: response));
      } catch (e) {
        emit(SearchError(errorMassage: e.toString()));
      }
    });
    on<SearchAnime>((event, emit) async {
      emit(SearchInitial());
      try {
        AnimeList response = await repository.getAnimeSearch(
            query: event.query, genres: event.genres, page: event.page);
        emit(SearchHasData(animeList: response));
      } catch (e) {
        emit(SearchError(errorMassage: e.toString()));
      }
    });
  }
}
