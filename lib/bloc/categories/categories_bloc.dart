import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final AnimeListDataSource repository;
  CategoriesBloc({required this.repository}) : super(CategoriesInitial()) {
    on<ChangeCategory>((event, emit) async {
      emit(CategoriesInitial());
      try {
        final response = event.newString == "top"
            ? await repository.getTopAnimes(page: event.newPage)
            : await repository.getSeasonAnimes(
                time: "upcoming", page: event.newPage);
        emit(CategoriesHasData(animeList: response));
      } catch (e) {
        emit(CategoriesError(errString: e.toString()));
      }
    });
  }
}
