import 'dart:io';

import 'package:animus/bloc/detail/detail_bloc.dart';
import 'package:animus/bloc/search/search_bloc.dart';
import 'package:animus/widgets/animes.dart';
import 'package:animus/widgets/custom_button.dart';
import 'package:animus/widgets/image_fade_bottom.dart';
import 'package:animus/widgets/poster_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  static const String route = '/detail';
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = Get.arguments['animeId'];
    BlocProvider.of<DetailBloc>(context).add(DetailLoad(id: id));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
        if (state is DetailInitial) {
          return Skeletonizer(
            enabled: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.replace(
                    width: double.infinity,
                    height: 300,
                    child: Container(),
                  ),
                  const SizedBox(
                    height: 83,
                  ),
                  twoButtons(context, null, null),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      "Synopsis",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ("aaaa").toString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    child: Text(
                      "You might like",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is DetailHasData) {
          final genresName = state.anime.data?.genres?.map((e) => e.malId);
          String? genresString = genresName?.join(",");
          context
              .read<SearchBloc>()
              .add(SearchAnime(genres: genresString.toString(), page: 1));
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                banner(state, context),
                const SizedBox(
                  height: 83,
                ),
                twoButtons(context, state.anime.data?.trailer?.url,
                    state.anime.data?.url),
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    "Synopsis",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (state.anime.data?.synopsis).toString(),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: Text(
                    "You might like",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                sameGenreList()
              ],
            ),
          );
        } else if (state is DetailHasError) {
          return Text(state.errorMassage);
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }

  SizedBox twoButtons(
      BuildContext context, String? youtubeString, String? malString) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Trailer',
              gradientColorStart: Color.fromARGB(255, 131, 32, 25),
              gradientColorEnd: Color.fromARGB(255, 67, 73, 153),
              textColor: Colors.white,
              onTap: () => launchUrl(Uri.parse(youtubeString ??
                  "https://www.youtube.com/watch?v=dQw4w9WgXcQ")),
            ),
          ),
          Expanded(
            child: CustomButton(
              text: 'MAL',
              gradientColorStart: Color.fromARGB(255, 67, 73, 153),
              gradientColorEnd: Color.fromARGB(255, 131, 32, 25),
              textColor: Colors.white,
              onTap: () => launchUrl(Uri.parse(
                  malString ?? "https://www.youtube.com/watch?v=dQw4w9WgXcQ")),
            ),
          )
        ],
      ),
    );
  }

  BlocBuilder<SearchBloc, SearchState> sameGenreList() {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
      if (searchState is SearchHasData) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Animes(
                id: searchState.animeList.data?[index].malId,
                title: (searchState.animeList.data?[index].title).toString(),
                imageUrl: (searchState
                        .animeList.data?[index].images?.jpg?.largeImageUrl)
                    .toString(),
                width: 200,
                height: 300,
                borderRadiusRadial: 24,
                rating: (searchState.animeList.data?[index].score),
                type: (searchState.animeList.data?[index].type).toString(),
              );
            },
            itemCount: searchState.animeList.data?.length,
          ),
        );
      } else if (searchState is SearchError) {
        return Text(searchState.errorMassage);
      } else {
        return const PosterSkeletonWidget();
      }
    });
  }

  Stack banner(DetailHasData state, BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      MaskImage(
          width: double.infinity,
          height: 300,
          imgUrl: (state.anime.data?.images?.jpg?.largeImageUrl).toString()),
      Positioned(
        bottom: -75,
        left: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      (state.anime.data?.images?.jpg?.largeImageUrl).toString(),
                      fit: BoxFit.cover,
                      width: 133,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  bannerDecoration(state),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Column bannerDecoration(DetailHasData state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            (state.anime.data?.title).toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
          ),
        ),
        Text(
          (state.anime.data?.type).toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
        ),
        tvCheck(state.anime.data?.score),
      ],
    );
  }

  Widget tvCheck(double? state) {
    if (state != null) {
      return Row(
        children: [
          const Icon(
            Icons.star,
            color: Color.fromARGB(255, 196, 118, 2),
            size: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            (state).toString(),
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)]),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }
}
