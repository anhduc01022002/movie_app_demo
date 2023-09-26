import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/movie/movie_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_cubit.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movie_app/presentation/widgets/app_error_widget.dart';
import 'package:movie_app/presentation/journeys/movie/movie_widget.dart';
import 'package:movie_app/presentation/journeys/movie_tab/movie_tab_widget.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_drawer_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCubit movieCubit;
  late MovieBackdropCubit movieBackdropCubit;
  late MovieTabCubit movieTabCubit;
  late SearchMovieCubit searchMovieCubit;

  @override
  void initState() {
    super.initState();
    movieCubit = getItInstance<MovieCubit>();
    movieBackdropCubit = movieCubit.movieBackdropCubit;
    movieTabCubit = getItInstance<MovieTabCubit>();
    searchMovieCubit = getItInstance<SearchMovieCubit>();
    movieCubit.loadCarousel();
  }

  @override
  void dispose() {
    super.dispose();
    movieCubit.close();
    movieBackdropCubit.close();
    movieTabCubit.close();
    searchMovieCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCubit,
        ),
        BlocProvider(
          create: (context) => movieBackdropCubit,
        ),
        BlocProvider(
          create: (context) => movieTabCubit,
        ),
        BlocProvider.value(
          value: searchMovieCubit,
        ),
      ],
      child: Scaffold(
        drawer: const NavigationDrawerCustom(),
        body: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.6,
                    child: MovieWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),
                  const FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: MovieTabWidget(),
                  ),
                ],
              );
            } else if (state is MovieError) {
              return AppErrorWidget(
                onPressed: () => movieCubit.loadCarousel(),
                errorType: state.errorType,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
