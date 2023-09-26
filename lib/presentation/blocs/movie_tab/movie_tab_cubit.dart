
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_coming_soon.dart';
import 'package:movie_app/domain/usecases/get_playing_now.dart';
import 'package:movie_app/domain/usecases/get_popular.dart';

part 'movie_tab_state.dart';

class MovieTabCubit extends Cubit<MovieTabState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabCubit({
    required this.getComingSoon,
    required this.getPlayingNow,
    required this.getPopular,
  }) : super(const MovieTabInitial());

  void movieTabChanged({int currentTabIndex = 0}) async {
    emit(MovieTabLoading(currentTabIndex: currentTabIndex));
    Either<AppError, List<MovieEntity>>? moviesEither;
    switch (currentTabIndex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getPlayingNow(NoParams());
        break;
      case 2:
        moviesEither = await getComingSoon(NoParams());
        break;
    }
    if (moviesEither != null){
      emit(moviesEither.fold(
            (l) => MovieTabLoadError(
          currentTabIndex: currentTabIndex,
          errorType: l.appErrorType,
        ),
            (movies) {
              return MovieTabChanged(
                currentTabIndex: currentTabIndex,
                movies: movies,
          );
        },
      ));
    }
  }
    // emit(MovieTabLoadError(
    //   currentTabIndex: event.currentTabIndex,
    //   errorType: AppErrorType.network,
    // ));
}
