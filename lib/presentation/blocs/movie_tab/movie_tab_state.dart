part of 'movie_tab_cubit.dart';

abstract class MovieTabState extends Equatable {
  final int currentTabIndex;

  const MovieTabState({required this.currentTabIndex});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabInitial extends MovieTabState {
  const MovieTabInitial() : super(currentTabIndex: 0);
}

class MovieTabChanged extends MovieTabState {
  final List<MovieEntity> movies;

  const MovieTabChanged({
    required int currentTabIndex,
    required this.movies,
  }) : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadError extends MovieTabState {
  final AppErrorType errorType;

  const MovieTabLoadError({
    required this.errorType,
    required int currentTabIndex,
  }) : super(currentTabIndex: currentTabIndex);
}

class MovieTabLoading extends MovieTabState {
  const MovieTabLoading({required int currentTabIndex}) : super(currentTabIndex: currentTabIndex);
}
