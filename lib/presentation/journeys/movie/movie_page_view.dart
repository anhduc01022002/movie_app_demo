import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movie_app/presentation/journeys/movie/animated_movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialPage;
  const MoviePageView({
    Key? key,
    required this.movies,
    required this.initialPage
  }) : assert(initialPage >= 0,'initialPage cannot be less than 0'),
        super(key: key);

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController _pageController;

  @override
  void initState(){
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.Sizes.dimen_10.h),
      height: screenUtil.screenHeight * 0.35,
      child: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index){
            final MovieEntity movie = widget.movies[index];
            return AnimatedMovieCardWidget(
                index: index,
                pageController: _pageController,
                posterPath: movie.posterPath,
                movieId: movie.id
            );
          },
          pageSnapping: true,
          itemCount: widget.movies.length,
          onPageChanged: (index){
            BlocProvider.of<MovieBackdropCubit>(context)
                .backdropChanged(widget.movies[index]);
          },
      ),
    );
  }
}
