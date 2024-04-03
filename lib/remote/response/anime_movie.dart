// ?To parse this JSON data, do
//?final animeList = animeListFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

AnimeList animeListFromJson(String str) => AnimeList.fromJson(json.decode(str));

String animeListToJson(AnimeList data) => json.encode(data.toJson());

Anime animeFromJson(String str) => Anime.fromJson(json.decode(str));

String animeToJson(Anime data) => json.encode(data.toJson());

class AnimeList extends Equatable {
  final Pagination? pagination;
  final List<Datum>? data;

  const AnimeList({
    this.pagination,
    this.data,
  });

  factory AnimeList.fromJson(Map<String, dynamic> json) => AnimeList(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [pagination, data];
}

class Anime extends Equatable {
  final Datum? data;

  const Anime({
    this.data,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        data: json["data"] == null ? null : Datum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  List<Object?> get props => [data];
}

class Datum extends Equatable {
  final int? malId;
  final String? url;
  final DatumImages? images;
  final List<Genre>? genres;
  final Trailer? trailer;
  final String? title;
  final String? titleEnglish;
  final String? type;
  final double? score;
  final String? synopsis;

  const Datum({
    this.synopsis,
    this.genres,
    this.malId,
    this.url,
    this.images,
    this.trailer,
    this.title,
    this.titleEnglish,
    this.type,
    this.score,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        malId: json["mal_id"],
        url: json["url"],
        images: json["images"] == null
            ? null
            : DatumImages.fromJson(json["images"]),
        trailer:
            json["trailer"] == null ? null : Trailer.fromJson(json["trailer"]),
        title: json["title"],
        titleEnglish: json["title_english"],
        type: json["type"],
        synopsis: json["synopsis"],
        score: json["score"]?.toDouble(),
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images?.toJson(),
        "trailer": trailer?.toJson(),
        "title": title,
        "title_english": titleEnglish,
        "type": type,
        "synopsis": synopsis,
        "score": score,
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props =>
      [malId, url, images, trailer, title, titleEnglish, type, score, genres];
}

class Genre extends Equatable {
  final int? malId;
  final String? type;
  final String? name;
  final String? url;

  const Genre({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        malId: json["mal_id"],
        type: json["type"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "type": type,
        "name": name,
        "url": url,
      };

  @override
  List<Object?> get props => [malId, type, name, url];
}

class DatumImages extends Equatable {
  final Jpg? jpg;

  const DatumImages({
    this.jpg,
  });

  factory DatumImages.fromJson(Map<String, dynamic> json) => DatumImages(
        jpg: json["jpg"] == null ? null : Jpg.fromJson(json["jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg?.toJson(),
      };

  @override
  List<Object?> get props => [jpg];
}

class Jpg extends Equatable {
  final String? largeImageUrl;

  const Jpg({
    this.largeImageUrl,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) => Jpg(
        largeImageUrl: json["large_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "large_image_url": largeImageUrl,
      };

  @override
  List<Object?> get props => [largeImageUrl];
}

class Trailer extends Equatable {
  final String? youtubeId;
  final String? url;
  final String? embedUrl;
  final TrailerImages? images;

  const Trailer({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
        youtubeId: json["youtube_id"],
        url: json["url"],
        embedUrl: json["embed_url"],
        images: json["images"] == null
            ? null
            : TrailerImages.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "youtube_id": youtubeId,
        "url": url,
        "embed_url": embedUrl,
        "images": images?.toJson(),
      };

  @override
  List<Object?> get props => [youtubeId, url, embedUrl, images];
}

class TrailerImages extends Equatable {
  final String? largeImageUrl;
  final String? maximumImageUrl;

  const TrailerImages({
    this.largeImageUrl =
        "https://resources.alleghenycounty.us/css/images/Default_No_Image_Available.png",
    this.maximumImageUrl =
        "https://resources.alleghenycounty.us/css/images/Default_No_Image_Available.png",
  });

  factory TrailerImages.fromJson(Map<String, dynamic> json) => TrailerImages(
        largeImageUrl: json["large_image_url"],
        maximumImageUrl: json["maximum_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "large_image_url": largeImageUrl,
        "maximum_image_url": maximumImageUrl,
      };
  @override
  List<Object?> get props => [largeImageUrl, maximumImageUrl];
}

class Pagination extends Equatable {
  final int? lastVisiblePage;
  final bool? hasNextPage;
  final int? currentPage;
  final Items? items;

  const Pagination({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        lastVisiblePage: json["last_visible_page"],
        hasNextPage: json["has_next_page"],
        currentPage: json["current_page"],
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "last_visible_page": lastVisiblePage,
        "has_next_page": hasNextPage,
        "current_page": currentPage,
        "items": items?.toJson(),
      };

  @override
  List<Object?> get props => [lastVisiblePage, hasNextPage, currentPage, items];
}

class Items extends Equatable {
  final int? count;
  final int? total;
  final int? perPage;

  const Items({
    this.count,
    this.total,
    this.perPage,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        count: json["count"],
        total: json["total"],
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "per_page": perPage,
      };

  @override
  List<Object?> get props => [count, total, perPage];
}
