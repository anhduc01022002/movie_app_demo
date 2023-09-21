import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;

  MovieBloc({
    required this.getTrending,
    required this.movieBackdropBloc,
  }) : super(MovieInitial()) {
    on<LoadEvent>(_onLoadEvent);
  }

  FutureOr<void> _onLoadEvent(LoadEvent event, Emitter<MovieState> emit) async {
    final movieEither = await getTrending(NoParams());
    movieEither.fold(
          (l) => emit(MovieError(l.appErrorType)),
          (movies) {
        emit(MovieLoaded(
          movies: movies,
          defaultIndex: event.defaultIndex,
        ));
        movieBackdropBloc.add(MovieBackdropChangedEvent(movies[event.defaultIndex]));
      },
    );
  }
}
