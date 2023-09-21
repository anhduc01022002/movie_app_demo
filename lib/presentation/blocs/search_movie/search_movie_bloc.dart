import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/movie_search_params.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc({
    required this.searchMovies,
  }) : super(SearchMovieInitial()) {
    on<SearchTermChangedEvent>((event, emit) async {
      if (event.searchTerm.length > 2) {
        emit(SearchMovieLoading());
        final Either<AppError, List<MovieEntity>> response =
        await searchMovies(MovieSearchParams(searchTerm: event.searchTerm));
        emit(
          response.fold(
                (l) => SearchMovieError(l.appErrorType),
                (r) => SearchMovieLoaded(r),
          ),
        );
      }
    });

    on<SuggestionSearchTermChangedEvent>((event, emit) async {
      if (event.searchTerm.length > 1) { // Tùy chỉnh số ký tự tối thiểu
        emit(SearchMovieLoading()); // Tùy chọn: hiển thị trạng thái tải
        final Either<AppError, List<MovieEntity>> response =
        await searchMovies(MovieSearchParams(searchTerm: event.searchTerm));
        emit(
          response.fold(
                (l) => SearchMovieError(l.appErrorType),
                (r) => SearchMovieSuggestionLoaded(r),
          ),
        );
      }
    });
  }
}
