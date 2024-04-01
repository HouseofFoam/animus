import 'package:animus/remote/response/anime_movie.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'anime_list_api.g.dart';

@RestApi(baseUrl: 'https://api.jikan.moe/v4/')
abstract class AnimeListApi {
  factory AnimeListApi(Dio dio) = _AnimeListApi;

  @GET('seasons/{time}')
  Future<AnimeList> getSeasonAnimes(
      {@Path('time') String time = 'now', @Query('page') int page = 1});

  @GET('top/anime')
  Future<AnimeList> getTopAnimes({@Query('page') int page = 1});
  @GET('anime')
  Future<AnimeList> getAnimeSearch(
      {@Query('page') int page = 1,
      @Query('q') String query = "",
      @Query('genres') String? genres});

  @GET('anime/{id}')
  Future<Anime> getAnimeById(@Path('id') int id);
}
