part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailHasData extends DetailState {
  final Anime anime;

  const DetailHasData({required this.anime});

  @override
  List<Object> get props => [anime];
}

final class DetailHasError extends DetailState {
  final String errorMassage;

  const DetailHasError({required this.errorMassage});

  @override
  List<Object> get props => [errorMassage];
}
