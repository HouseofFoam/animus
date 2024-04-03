import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_pointer_event.dart';
part 'page_pointer_state.dart';

class PagePointerBloc extends Bloc<PagePointerEvent, PagePointerState> {
  PagePointerBloc() : super(const PagePointerInitial()) {
    on<ChangePagePointer>((event, emit) {
      emit(PagePointerInitial(nowPage: event.changedNewPointer));
    });
  }
}
