import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_search_params.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final SearchMovies searchMovies;
  final LoadingCubit loadingCubit;

  SearchMovieCubit({
    required this.loadingCubit,
    required this.searchMovies,
  }) : super(SearchMovieInitial());
  void searchTermChanged(String searchTerm) async {
    loadingCubit.show();
    if (searchTerm.length > 2) {
      emit(SearchMovieLoading());
      final Either<AppError, List<MovieEntity>> response =
      await searchMovies(MovieSearchParams(searchTerm: searchTerm));
      emit(response.fold(
            (l) => SearchMovieError(l.appErrorType),
            (r) => SearchMovieLoaded(r),
      ));
    }
    loadingCubit.hide();
  }

  void suggestionSearchTermChanged(String searchTerm) async {
    loadingCubit.show();
    if (searchTerm.length > 1) {
      emit(SearchMovieLoading());
      final Either<AppError, List<MovieEntity>> response =
      await searchMovies(MovieSearchParams(searchTerm: searchTerm));
      emit(response.fold(
            (l) => SearchMovieError(l.appErrorType),
            (r) => SearchMovieSuggestionLoaded(r),
      ));
    }
    loadingCubit.hide();
  }
}
