import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/videos/videos_bloc.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteBloc favoriteBloc;

  MovieDetailBloc({
    required this.castBloc,
    required this.getMovieDetail,
    required this.videosBloc,
    required this.favoriteBloc,
  }) : super(MovieDetailInitial()) {
    on<MovieDetailLoadEvent>((event, emit) async {
      final Either<AppError, MovieDetailEntity> eitherResponse =
          await getMovieDetail(MovieParams(event.movieId));

      eitherResponse.fold(
        (l) => emit(MovieDetailError()),
        (r) => emit(MovieDetailLoaded(r)),
      );
      
      favoriteBloc.add(CheckIfFavoriteMovieEvent(event.movieId));
      castBloc.add(LoadCastEvent(movieId: event.movieId));
      videosBloc.add(LoadVideosEvent(event.movieId));
    });
  }
}
