import 'package:animus/bloc/categories/categories_bloc.dart';
import 'package:animus/bloc/page_pointer/page_pointer_bloc.dart';
import 'package:animus/bloc/page_total/page_total_bloc.dart';
import 'package:animus/widgets/animes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesWidget extends StatelessWidget {
  static const route = '/categories';
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String categories = Get.arguments['categories'];
    BlocProvider.of<CategoriesBloc>(context)
        .add(ChangeCategory(newString: categories));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BlocBuilder<PageTotalBloc, PageTotalState>(
        builder: (context1, state) {
          if (state is PageTotalHasData) {
            return BlocBuilder<PagePointerBloc, PagePointerState>(
              builder: (context, pointerState) {
                if (pointerState is PagePointerInitial) {
                  return NumberPaginator(
                    numberPages: state.totalPage,
                    onPageChange: (p0) {
                      context1.read<PagePointerBloc>().add(ChangePagePointer(
                            changedNewPointer: p0 + 1,
                          ));
                      context.read<CategoriesBloc>().add(ChangeCategory(
                          newString: categories, newPage: p0 + 1));
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
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 131, 32, 25),
                Color.fromARGB(255, 67, 73, 153)
              ])),
              child: SafeArea(
                child: Text(
                  categories.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
          BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
            if (state is CategoriesHasData) {
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
            } else if (state is CategoriesError) {
              return Center(
                child: Text(state.errString),
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
