part of 'movie_cubit.dart';

abstract class MovieState extends Equatable{
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState{}

class MovieError extends MovieState{
  final AppErrorType errorType;

  const MovieError(this.errorType);
}

class MovieLoaded extends MovieState {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieLoaded({
    required this.movies,
    this.defaultIndex = 0,
  }) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  @override
  List<Object> get props => [movies, defaultIndex];
}
