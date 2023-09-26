import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/cast/cast_cubit.dart';
import 'package:movie_app/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie_app/presentation/journeys/movie_detail/videos_widget.dart';
import 'package:movie_app/presentation/blocs/videos/videos_cubit.dart';
import 'package:movie_app/presentation/journeys/movie_detail/big_poster.dart';
import 'package:movie_app/presentation/journeys/movie_detail/cast_widget.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movie_app/common/constants/translation_constants.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({Key? key, required this.movieDetailArguments})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailCubit _movieDetailCubit;
  late CastCubit _castCubit;
  late VideosCubit _videosCubit;
  late FavoriteCubit _favoriteCubit;

  @override
  void initState() {
    super.initState();
    _movieDetailCubit = getItInstance<MovieDetailCubit>();
    _castCubit = _movieDetailCubit.castBloc;
    _videosCubit = _movieDetailCubit.videosCubit;
    _favoriteCubit = _movieDetailCubit.favoriteCubit;
    _movieDetailCubit.loadMovieDetail(widget.movieDetailArguments.movieId,);
  }

  @override
  void dispose() {
    _movieDetailCubit.close();
    _castCubit.close();
    _videosCubit.close();
    _favoriteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailCubit),
          BlocProvider.value(value: _castCubit),
          BlocProvider.value(value: _videosCubit),
          BlocProvider.value(value: _favoriteCubit),
        ],
        child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetail,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.Sizes.dimen_16.w,
                        vertical: Sizes.Sizes.dimen_8.h,
                      ),
                      child: Text(
                        movieDetail.overview,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.t(context),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const CastWidget(),
                    VideosWidget(videosBloc: _videosCubit),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
