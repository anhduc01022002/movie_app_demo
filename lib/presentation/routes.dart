
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movie_app/presentation/journeys/home_screen.dart';
import 'package:movie_app/presentation/journeys/loading/loading_screen.dart';
import 'package:movie_app/presentation/journeys/login/login_screen.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_arguments.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_screen.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_screen.dart';

class Routes{
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
    RouteList.initial: (context) => LoginScreen(),
    RouteList.home: (context) => const HomeScreen(),
    RouteList.movieDetail: (context) => MovieDetailScreen(movieDetailArguments: setting.arguments as MovieDetailArguments,),
    RouteList.watchTrailer: (context) => WatchVideoScreen(watchVideoArguments: setting.arguments as WatchVideoArguments,),
    RouteList.favorite: (context) => const FavoriteScreen(),
  };
}