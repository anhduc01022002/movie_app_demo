part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable{
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends MovieEvent{
  final int defaultIndex;

  const LoadEvent({this.defaultIndex = 0}) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');

  @override
  List<Object> get props => [defaultIndex];
}