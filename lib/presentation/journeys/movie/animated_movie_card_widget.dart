import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/presentation/journeys/movie/movie_card_widget.dart';

class AnimatedMovieCardWidget extends StatelessWidget{
  final int index;
  final int movieId;
  final String posterPath;
  final PageController pageController;

  const AnimatedMovieCardWidget({
    Key? key,
    required this.pageController,
    required this.posterPath,
    required this.index,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final ScreenUtil screenUtil = ScreenUtil();
    return AnimatedBuilder(
        animation: pageController,
        builder: (context,child){
          double value = 1;
          if (pageController.position.haveDimensions){
            double? page = pageController.page;
            value = page != null ? (page - index) : 0;
            value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Curves.easeIn.transform(value) *
                    screenUtil.screenHeight *
                    0.35,
                width: Sizes.Sizes.dimen_230.w,
                child: child,
              ),
            );
          }else{
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Curves.easeIn.transform(index == 0 ? value : value * 0.5) * screenUtil.screenHeight * 0.35,
                width: Sizes.Sizes.dimen_230.w,
                child: child,
              ),
            );
          }
        },
        child: MovieCardWidget(
          movieId: movieId,
          posterPath: posterPath,
        ),
    );
  }
}