import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_total_event.dart';
part 'page_total_state.dart';

class PageTotalBloc extends Bloc<PageTotalEvent, PageTotalState> {
  PageTotalBloc() : super(const PageTotalHasData()) {
    on<PageTotalChange>((event, emit) {
      if (event.newPageTotal == -1) {
        emit(PageTotalNoData());
      } else {
        emit(PageTotalHasData(totalPage: event.newPageTotal));
      }
    });
  }
}
