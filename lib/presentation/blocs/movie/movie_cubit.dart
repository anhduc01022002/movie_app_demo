import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_trending.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';

import '../loading/loading_cubit.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetTrending getTrending;
  final MovieBackdropCubit movieBackdropCubit;
  final LoadingCubit loadingCubit;

  MovieCubit({
    required this.loadingCubit,
    required this.getTrending,
    required this.movieBackdropCubit,
  }) : super(MovieInitial());
  void loadCarousel({int defaultIndex = 0}) async {
    loadingCubit.show();
    final moviesEither = await getTrending(NoParams());
    emit(moviesEither.fold(
          (l) => MovieError(l.appErrorType),
          (movies) {
        movieBackdropCubit.backdropChanged(movies[defaultIndex]);
        return MovieLoaded(
          movies: movies,
          defaultIndex: defaultIndex,
        );
      },
    ));
    loadingCubit.hide();
  }
}
