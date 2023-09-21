import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_app/presentation/journeys/movie_tab/movie_list_view_builder.dart';
import 'package:movie_app/presentation/journeys/movie_tab/movie_tab_constants.dart';
import 'package:movie_app/presentation/journeys/movie_tab/tab_title_widget.dart';
import 'package:movie_app/presentation/translation_constants.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';

class MovieTabWidget extends StatefulWidget {
  const MovieTabWidget({Key? key}) : super(key: key);

  @override
  State<MovieTabWidget> createState() => _MovieTabWidgetState();
}

class _MovieTabWidgetState extends State<MovieTabWidget>
    with SingleTickerProviderStateMixin {
  MovieTabBloc get movieTabBloc => BlocProvider.of<MovieTabBloc>(context);

  @override
  void initState() {
    super.initState();
    movieTabBloc.add(const MovieTabChangedEvent(currentTabIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabBloc, MovieTabState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.Sizes.dimen_4.h),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < MovieTabConstants.movieTabs.length; i++)
                    TabTitleWidget(
                      title: MovieTabConstants.movieTabs[i].title,
                      onTap: () => _onTapTap(i),
                      isSelected: MovieTabConstants.movieTabs[i].index ==
                          state.currentTabIndex,
                    )
                ],
              ),
              if (state is MovieTabChanged)
                state.movies?.isEmpty ?? true ?
                Expanded(
                    child: Center(
                      child: Text(
                        TranslationConstants.noMovies.t(context),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                ) :
                Expanded(
                  child: MovieListViewBuilder(movies: state.movies),
                ),
              if (state is MovieTabLoadError)
                Expanded(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    onPressed: () => movieTabBloc.add(
                      MovieTabChangedEvent(
                          currentTabIndex: state.currentTabIndex,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onTapTap(int index) {
    if (movieTabBloc.state.currentTabIndex != index) {
      movieTabBloc.add(MovieTabChangedEvent(currentTabIndex: index));
    }
  }
}
