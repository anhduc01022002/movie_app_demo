import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';

part 'movie_tab_event.dart';
part 'movie_tab_state.dart';

class MovieTabBloc extends Bloc<MovieTabEvent, MovieTabState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabBloc({
    required this.getComingSoon,
    required this.getPlayingNow,
    required this.getPopular,
  }) : super(const MovieTabInitial()) {
    on<MovieTabChangedEvent>(_onMovieTabChangedEvent);
  }

  FutureOr<void> _onMovieTabChangedEvent(MovieTabChangedEvent event, Emitter<MovieTabState> emit) async {
    Either<AppError, List<MovieEntity>> moviesEither;
    switch (event.currentTabIndex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getPlayingNow(NoParams());
        break;
      case 2:
        moviesEither = await getComingSoon(NoParams());
        break;
      default:
        moviesEither = await getPopular(NoParams());
        break;
    }
    moviesEither.fold(
          (l) {
        emit(MovieTabLoadError(
          currentTabIndex: event.currentTabIndex,
          errorType: l.appErrorType,
        ));
      },
          (movies) {
        emit(MovieTabChanged(
          currentTabIndex: event.currentTabIndex,
          movies: movies,
        ));
      },
    );
    // emit(MovieTabLoadError(
    //   currentTabIndex: event.currentTabIndex,
    //   errorType: AppErrorType.network,
    // ));
  }
}
