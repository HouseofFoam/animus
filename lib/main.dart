import 'package:animus/bloc/anime_list/anime_list_bloc.dart';
import 'package:animus/bloc/anime_top/anime_top_bloc.dart';
import 'package:animus/bloc/anime_upcoming/anime_upcoming_bloc.dart';
import 'package:animus/bloc/detail/detail_bloc.dart';
import 'package:animus/bloc/page_pointer/page_pointer_bloc.dart';
import 'package:animus/bloc/page_total/page_total_bloc.dart';
import 'package:animus/bloc/search/search_bloc.dart';
import 'package:animus/bloc/search_query/search_query_bloc.dart';
import 'package:animus/pages/detail.dart';
import 'package:animus/pages/home.dart';
import 'package:animus/pages/search.dart';
import 'package:animus/remote/datasource/anime_list_data_source.dart';
import 'package:animus/remote/repository/anime_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimeListDataSource repository = AnimeListRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AnimeListBloc(repository: repository)),
        BlocProvider(create: (context) => AnimeTopBloc(repository: repository)),
        BlocProvider(
            create: (context) => AnimeUpcomingBloc(repository: repository)),
        BlocProvider(create: (context) => SearchBloc(repository: repository)),
        BlocProvider(create: (context) => DetailBloc(repository: repository)),
        BlocProvider(create: (context) => PagePointerBloc()),
        BlocProvider(create: (context) => PageTotalBloc()),
        BlocProvider(create: (context) => SearchQueryBloc()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
        debugShowCheckedModeBanner: false,
        home: Home(),
        getPages: [
          GetPage(name: Home.route, page: () => const Home()),
          GetPage(name: Search.route, page: () => const Search()),
          GetPage(name: DetailPage.route, page: () => const DetailPage())
        ],
      ),
    );
  }
}
