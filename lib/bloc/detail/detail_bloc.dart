import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final AnimeListDataSource repository;
  DetailBloc({required this.repository}) : super(DetailInitial()) {
    on<DetailLoad>((event, emit) async {
      emit(DetailInitial());
      try {
        final response = await repository.getAnimeById(id: event.id);
        emit(DetailHasData(anime: response));
      } catch (e) {
        emit(DetailHasError(errorMassage: e.toString()));
      }
    });
  }
}
