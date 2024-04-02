import 'package:animus/remote/response/anime_movie.dart';

abstract class AnimeListDataSource {
  Future<AnimeList> getSeasonAnimes({String time, int page});
  Future<AnimeList> getTopAnimes({int page});
  Future<AnimeList> getAnimeSearch({String query, String genres, int page});
  Future<Anime> getAnimeById({required int id});
}
