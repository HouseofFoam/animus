import 'package:animus/bloc/page_pointer/page_pointer_bloc.dart';
import 'package:animus/bloc/page_total/page_total_bloc.dart';
import 'package:animus/bloc/search/search_bloc.dart';
import 'package:animus/bloc/search_query/search_query_bloc.dart';
import 'package:animus/widgets/Animes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Search extends StatelessWidget {
  static const String route = '/search';
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final NumberPaginatorController controller = NumberPaginatorController();
    BlocProvider.of<SearchBloc>(context).add(LoadAnimeList());
    return Scaffold(
      bottomNavigationBar: BlocBuilder<PageTotalBloc, PageTotalState>(
        builder: (context1, state) {
          if (state is PageTotalHasData) {
            return BlocBuilder<PagePointerBloc, PagePointerState>(
              builder: (context, pointerState) {
                if (pointerState is PagePointerInitial) {
                  return NumberPaginator(
                    config: const NumberPaginatorUIConfig(
                        buttonSelectedBackgroundColor:
                            Color.fromARGB(255, 131, 32, 25),
                        buttonSelectedForegroundColor: Colors.white,
                        buttonUnselectedForegroundColor: Colors.grey),
                    controller: controller,
                    numberPages: state.totalPage,
                    onPageChange: (p0) {
                      context1.read<PagePointerBloc>().add(ChangePagePointer(
                            changedNewPointer: p0 + 1,
                          ));
                    },
                  );
                } else {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                  );
                }
              },
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
            );
          }
        },
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 131, 32, 25),
              Color.fromARGB(255, 67, 73, 153)
            ])),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<PagePointerBloc, PagePointerState>(
                  builder: (context, state) {
                    if (state is PagePointerInitial) {
                      return BlocBuilder<SearchQueryBloc, SearchQueryState>(
                        builder: (context, queryState) {
                          if (queryState is SearchQueryInitial) {
                            context.read<SearchBloc>().add(SearchAnime(
                                page: state.nowPage,
                                query: queryState.searchQuery));
                            return TextField(
                                onChanged: (value) {
                                  controller.navigateToPage(0);
                                  context
                                      .read<SearchQueryBloc>()
                                      .add(ChangeQuery(newQuery: value));
                                },
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8)),
                                    hintText: "Search your anime",
                                    icon: GestureDetector(
                                      onTap: () => Get.back(),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            if (state is SearchHasData) {
              final int perPage =
                  state.animeList.pagination?.items?.perPage != null
                      ? (state.animeList.pagination?.items?.perPage)!.toInt()
                      : 1;
              final int totalItem =
                  state.animeList.pagination?.items?.total != null
                      ? (state.animeList.pagination?.items?.total)!.toInt()
                      : 1;
              final pageTotal = totalItem ~/ perPage;
              context.read<PageTotalBloc>().add(PageTotalChange(
                  newPageTotal: pageTotal > 0 ? pageTotal : -1));
              return Expanded(
                child: GridView.builder(
                  itemBuilder: (context, index) {
                    return Animes(
                      title: (state.animeList.data?[index].title).toString(),
                      imageUrl: (state.animeList.data?[index].images?.jpg
                              ?.largeImageUrl)
                          .toString(),
                      height: 340,
                      borderRadiusRadial: 12,
                      rating: (state.animeList.data?[index].score),
                      id: state.animeList.data?[index].malId,
                    );
                  },
                  itemCount: state.animeList.data?.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 12,
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      mainAxisExtent: 428),
                ),
              );
            } else if (state is SearchError) {
              return Center(
                child: Text(state.errorMassage),
              );
            } else {
              return Expanded(
                child: GridView.builder(
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Skeleton.replace(
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 12,
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      mainAxisExtent: 380),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
