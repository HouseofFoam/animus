import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesIndex()) {
    on<PickCategory>((event, emit) {
      emit(const CategoriesIndex());
    });

    on<ChangeCategory>((event, emit) {
      emit(CategoriesIndex(index: event.newIndex));
    });
  }
}
