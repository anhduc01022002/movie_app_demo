import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/presentation/journeys/movie/movie_backdrop_widget.dart';
import 'package:movie_app/presentation/journeys/movie/movie_data_widget.dart';
import 'package:movie_app/presentation/journeys/movie/movie_page_view.dart';
import 'package:movie_app/presentation/widgets/movie_app_bar.dart';
import 'package:movie_app/presentation/widgets/separator.dart';

class MovieWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieWidget({
    Key? key,
    required this.movies,
    required this.defaultIndex,
  }) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const MovieBackdropWidget(),
        SingleChildScrollView(  // wrap your Column in a SingleChildScrollView
          child: Column(
            children: [
              const MovieAppBar(),
              MoviePageView(
                movies: movies,
                initialPage: defaultIndex,
              ),
              const MovieDataWidget(),
              const Separator(),
            ],
          ),
        ),
      ],
    );
  }
}
