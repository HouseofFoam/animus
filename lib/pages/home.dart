import 'package:animus/bloc/anime_list/anime_list_bloc.dart';
import 'package:animus/bloc/anime_top/anime_top_bloc.dart';
import 'package:animus/bloc/anime_upcoming/anime_upcoming_bloc.dart';
import 'package:animus/pages/categories.dart';
import 'package:animus/pages/search.dart';
import 'package:animus/widgets/Animes.dart';
import 'package:animus/widgets/poster_skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Home extends StatelessWidget {
  static const String route = '/';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AnimeListBloc>(context).add(LoadAnimeList());
    BlocProvider.of<AnimeTopBloc>(context).add(LoadAnimeTop());
    BlocProvider.of<AnimeUpcomingBloc>(context).add(LoadAnimeUpcoming());

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 140),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 131, 32, 25),
            Color.fromARGB(255, 67, 73, 153)
          ])),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/ghost.png',
                      color: Colors.grey[200],
                      width: 40,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "ANIMUS",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[200]),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                      readOnly: true,
                      onTap: () => Get.toNamed(Search.route),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8)),
                        hintText: "Search your anime",
                        suffixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 67, 73, 153),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            animeList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Anime",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(CategoriesWidget.route,
                        arguments: {'categories': "top"}),
                    child: const Text(
                      "See More",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromARGB(255, 131, 32, 25)),
                    ),
                  ),
                ],
              ),
            ),
            animeTop(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upcoming Anime",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(CategoriesWidget.route,
                        arguments: {'categories': "upcoming"}),
                    child: const Text(
                      "See More",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromARGB(255, 131, 32, 25)),
                    ),
                  ),
                ],
              ),
            ),
            animeUpcoming()
          ],
        ),
      ),
    );
  }

  BlocBuilder<AnimeListBloc, AnimeListState> animeList() {
    return BlocBuilder<AnimeListBloc, AnimeListState>(
        builder: (context, state) {
      if (state is AnimeListInitial) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeletonizer(
              enabled: true,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.red,
              )),
        ));
      } else if (state is AnimeListHasData) {
        final randomizedList = state.animeList.data;
        randomizedList?.shuffle();
        return FlutterCarousel.builder(
          itemBuilder: (context, index, pageViewIndex) {
            final banner =
                randomizedList?[index].trailer?.images?.largeImageUrl;
            final banner2 = randomizedList?[index].images?.jpg?.largeImageUrl;
            return Animes(
              id: state.animeList.data?[index].malId,
              title: (randomizedList?[index].title).toString(),
              imageUrl: (banner ?? banner2).toString(),
              width: MediaQuery.of(context).size.width,
              height: 190,
              gapBetween: 8,
            );
          },
          itemCount: 3,
          options: CarouselOptions(
            height: 270,
            showIndicator: true,
            slideIndicator: const CircularSlideIndicator(
              currentIndicatorColor: Color.fromARGB(125, 131, 32, 25),
              indicatorBackgroundColor: Color.fromARGB(125, 94, 94, 94),
            ),
            autoPlay: true,
          ),
        );
      } else if (state is AnimeListError) {
        return Center(
          child: Text(state.errorMassage),
        );
      } else {
        return const Center(
          child: Text(""),
        );
      }
    });
  }

  BlocBuilder<AnimeTopBloc, AnimeTopState> animeTop() {
    return BlocBuilder<AnimeTopBloc, AnimeTopState>(builder: (context, state) {
      if (state is AnimeTopInitial) {
        return const PosterSkeletonWidget();
      } else if (state is AnimeTopHasData) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Animes(
                id: state.animeList.data?[index].malId,
                title: (state.animeList.data?[index].title).toString(),
                imageUrl:
                    (state.animeList.data?[index].images?.jpg?.largeImageUrl)
                        .toString(),
                width: 200,
                height: 300,
                borderRadiusRadial: 24,
                rating: (state.animeList.data?[index].score),
                type: (state.animeList.data?[index].type).toString(),
              );
            },
            itemCount: state.animeList.data?.length,
          ),
        );
      }
      if (state is AnimeTopError) {
        return Center(
          child: Text(state.errorMassage),
        );
      } else {
        return const Center(
          child: Text(""),
        );
      }
    });
  }

  BlocBuilder<AnimeUpcomingBloc, AnimeUpcomingState> animeUpcoming() {
    return BlocBuilder<AnimeUpcomingBloc, AnimeUpcomingState>(
        builder: (context, state) {
      if (state is AnimeUpcomingInitial) {
        return const PosterSkeletonWidget();
      } else if (state is AnimeUpcomingHasData) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Animes(
                id: state.animeList.data?[index].malId,
                title: (state.animeList.data?[index].title).toString(),
                imageUrl:
                    (state.animeList.data?[index].images?.jpg?.largeImageUrl)
                        .toString(),
                width: 200,
                height: 300,
                borderRadiusRadial: 24,
                type: (state.animeList.data?[index].type).toString(),
              );
            },
            itemCount: state.animeList.data?.length,
          ),
        );
      } else if (state is AnimeUpcomingError) {
        return Center(
          child: Text(state.errorMassage),
        );
      } else {
        return const Center(
          child: Text(""),
        );
      }
    });
  }

  // Padding categoriesChooser() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(999),
  //       child: Container(
  //         width: double.infinity,
  //         height: 40,
  //         color: Colors.white,
  //         child: BlocBuilder<CategoriesBloc, CategoriesState>(
  //           builder: (context, state) {
  //             if (state is CategoriesIndex) {
  //               return Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         context.read<AnimeListBloc>().add(
  //                             const AddParameterAnime(
  //                                 paramType: '', paramTime: 'now'));
  //                         context
  //                             .read<CategoriesBloc>()
  //                             .add(const ChangeCategory(newIndex: 0));
  //                       },
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(999),
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           padding: const EdgeInsets.all(8),
  //                           color:
  //                               state.index == 0 ? Colors.black : Colors.white,
  //                           child: Text(
  //                             "On Going",
  //                             style: TextStyle(
  //                               color: state.index == 0
  //                                   ? Colors.white
  //                                   : Colors.black,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         context.read<AnimeListBloc>().add(
  //                             const AddParameterAnime(
  //                                 paramType: '', paramTime: 'upcoming'));
  //                         context
  //                             .read<CategoriesBloc>()
  //                             .add(const ChangeCategory(newIndex: 1));
  //                       },
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(999),
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           padding: const EdgeInsets.all(8),
  //                           color:
  //                               state.index == 1 ? Colors.black : Colors.white,
  //                           child: Text(
  //                             "Upcoming",
  //                             style: TextStyle(
  //                               color: state.index == 1
  //                                   ? Colors.white
  //                                   : Colors.black,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         context.read<AnimeListBloc>().add(
  //                             const AddParameterAnime(
  //                                 paramType: 'trending', paramTime: ''));
  //                         context
  //                             .read<CategoriesBloc>()
  //                             .add(const ChangeCategory(newIndex: 2));
  //                       },
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(999),
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           padding: const EdgeInsets.all(8),
  //                           color:
  //                               state.index == 2 ? Colors.black : Colors.white,
  //                           child: Text(
  //                             "Top Anime",
  //                             style: TextStyle(
  //                               color: state.index == 2
  //                                   ? Colors.white
  //                                   : Colors.black,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             } else {
  //               return const Text("There is a problem!");
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
