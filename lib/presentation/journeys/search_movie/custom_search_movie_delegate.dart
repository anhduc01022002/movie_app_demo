import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/journeys/search_movie/search_movie_card.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';
import 'package:movie_app/presentation/translation_constants.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate(this.searchMovieBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    Color bodyColor = Theme.of(context).scaffoldBackgroundColor;

    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: bodyColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.greySubtitle1,
        border: InputBorder.none,
      ),
    );
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: query.isEmpty ? null : () => query = '',
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: Sizes.dimen_12.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(
      SearchTermChangedEvent(query),
    );

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      bloc: searchMovieBloc,
      builder: (context, state) {
        if (state is SearchMovieError) {
          return AppErrorWidget(
            errorType: state.errorType,
            onPressed: () => searchMovieBloc.add(SearchTermChangedEvent(query)),
          );
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
                child: Text(
                  TranslationConstants.noMoviesSearched.t(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => SearchMovieCard(
              movie: movies[index],
            ),
            itemCount: movies.length,
            scrollDirection: Axis.vertical,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      searchMovieBloc.add(
        SuggestionSearchTermChangedEvent(query),
      );
      return BlocBuilder<SearchMovieBloc, SearchMovieState>(
        bloc: searchMovieBloc,
        builder: (context, state) {
          if (state is SearchMovieSuggestionLoaded) {
            final suggestions = state.suggestions;
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    suggestions[index].posterPath != null
                        ? '${ApiConstants.BASE_IMAGE_URL}${suggestions[index].posterPath}'
                        : 'path_to_default_image',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Some errors occurred!');
                    },
                  ),
                ),
                title: Text(suggestions[index].title),
                onTap: () {
                  query = suggestions[index].title;
                  showResults(context);
                },
              ),
              itemCount: suggestions.length,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

}
