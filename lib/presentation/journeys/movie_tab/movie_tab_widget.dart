import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_cubit.dart';
import 'package:movie_app/presentation/journeys/loading/loading_circle.dart';
import 'package:movie_app/presentation/journeys/movie_tab/movie_list_view_builder.dart';
import 'package:movie_app/presentation/journeys/movie_tab/movie_tab_constants.dart';
import 'package:movie_app/presentation/journeys/movie_tab/tab_title_widget.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';

class MovieTabWidget extends StatefulWidget {
  const MovieTabWidget({Key? key}) : super(key: key);

  @override
  State<MovieTabWidget> createState() => _MovieTabWidgetState();
}

class _MovieTabWidgetState extends State<MovieTabWidget>
    with SingleTickerProviderStateMixin {
  MovieTabCubit get movieTabCubit => BlocProvider.of<MovieTabCubit>(context);

  @override
  void initState() {
    super.initState();
    movieTabCubit.movieTabChanged(currentTabIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabCubit, MovieTabState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0;
                  i < MovieTabConstants.movieTabs.length;
                  i++)
                    TabTitleWidget(
                      title: MovieTabConstants.movieTabs[i].title,
                      onTap: () => _onTabTapped(i),
                      isSelected: MovieTabConstants.movieTabs[i].index ==
                          state.currentTabIndex,
                    )
                ],
              ),
              if (state is MovieTabChanged)
                state.movies?.isEmpty ?? true
                    ? Expanded(
                  child: Center(
                    child: Text(
                      TranslationConstants.noMovies.t(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
                    : Expanded(
                  child: MovieListViewBuilder(movies: state.movies),
                ),
              if (state is MovieTabLoadError)
                Expanded(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    onPressed: () => movieTabCubit.movieTabChanged(
                      currentTabIndex: state.currentTabIndex,
                    ),
                  ),
                ),
              if (state is MovieTabLoading)
                Expanded(
                  child: Center(
                    child: LoadingCircle(
                      size: Sizes.dimen_100.w,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onTabTapped(int index) {
    movieTabCubit.movieTabChanged(currentTabIndex: index);
  }
}
