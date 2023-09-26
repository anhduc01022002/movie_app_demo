import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/domain/entities/movie_detail_entity.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;
  const MovieDetailAppBar({super.key, required this.movieDetailEntity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white : AppColor.vulcan,
                size: Sizes.Sizes.dimen_20.h,
              ),
            ),
            BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state is IsFavoriteMovie) {
                  return GestureDetector(
                    onTap: () => BlocProvider.of<FavoriteCubit>(context).
                      toggleFavoriteMovie(
                        MovieEntity.fromMovieDetailEntity(movieDetailEntity),
                        state.isMovieFavorite,
                      ),
                    child: Icon(
                      state.isMovieFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white : AppColor.vulcan,
                      size: Sizes.Sizes.dimen_20.h,
                    ),
                  );
                } else {
                  return Icon(
                    Icons.favorite_border,
                    color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white : AppColor.vulcan,
                    size: Sizes.Sizes.dimen_20.h,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
