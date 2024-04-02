import 'package:animus/remote/api/anime_list_api.dart';
import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/response/anime_movie.dart';
import 'package:dio/dio.dart';

class AnimeListRepository extends AnimeListDataSource {
  final AnimeListApi _animeListApi = AnimeListApi(Dio(BaseOptions(
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5))));

  @override
  Future<AnimeList> getTopAnimes({int page = 1}) {
    return _animeListApi.getTopAnimes(page: page);
  }

  @override
  Future<AnimeList> getSeasonAnimes({String time = 'upcoming', int page = 1}) {
    return _animeListApi.getSeasonAnimes(time: time, page: page);
  }

  @override
  Future<AnimeList> getAnimeSearch(
      {String query = "", String genres = "", int page = 1}) {
    return _animeListApi.getAnimeSearch(
        query: query, genres: genres, page: page);
  }

  @override
  Future<Anime> getAnimeById({required int id}) {
    return _animeListApi.getAnimeById(id);
  }
}
