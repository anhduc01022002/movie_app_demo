import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/check_if_movie_favorite.dart';
import 'package:movie_app/domain/usecases/delete_favorite_movie.dart';
import 'package:movie_app/domain/usecases/get_favorite_movies.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfMovieFavorite checkIfMovieFavorite;

  FavoriteBloc({
    required this.saveMovie,
    required this.getFavoriteMovies,
    required this.deleteFavoriteMovie,
    required this.checkIfMovieFavorite,
  }) : super(FavoriteInitial()) {
    on<ToggleFavoriteMovieEvent>((event, emit) async {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(event.movieEntity.id));
      } else {
        await saveMovie(event.movieEntity);
      }
      final response = await checkIfMovieFavorite(MovieParams(event.movieEntity.id));
      response.fold(
            (l) => emit(FavoriteMoviesError()),
            (r) => emit(IsFavoriteMovie(r)),
      );
    });

    on<LoadFavoriteMovieEvent>((event, emit) async {
      final Either<AppError, List<MovieEntity>> response = await getFavoriteMovies(NoParams());
      response.fold(
            (l) => emit(FavoriteMoviesError()),
            (r) => emit(FavoriteMoviesLoaded(r)),
      );
    });

    on<DeleteFavoriteMovieEvent>((event, emit) async {
      await deleteFavoriteMovie(MovieParams(event.movieId));
      final Either<AppError, List<MovieEntity>> response = await getFavoriteMovies(NoParams());
      response.fold(
            (l) => emit(FavoriteMoviesError()),
            (r) => emit(FavoriteMoviesLoaded(r)),
      );
    });

    on<CheckIfFavoriteMovieEvent>((event, emit) async {
      final response = await checkIfMovieFavorite(MovieParams(event.movieId));
      response.fold(
            (l) => emit(FavoriteMoviesError()),
            (r) => emit(IsFavoriteMovie(r)),
      );
    });
  }
}
