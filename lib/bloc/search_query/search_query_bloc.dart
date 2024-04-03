import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_query_event.dart';
part 'search_query_state.dart';

class SearchQueryBloc extends Bloc<SearchQueryEvent, SearchQueryState> {
  SearchQueryBloc() : super(const SearchQueryInitial()) {
    on<ChangeQuery>((event, emit) {
      emit(SearchQueryInitial(searchQuery: event.newQuery));
    });
  }
}
