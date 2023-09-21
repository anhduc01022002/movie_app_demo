import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/blocs/movie/movie_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_drawer.dart'
    as Drawer;
import 'package:movie_app/presentation/widgets/app_error_widget.dart';
import 'package:movie_app/presentation/journeys/movie/movie_widget.dart';
import 'package:movie_app/presentation/journeys/movie_tab/movie_tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieBloc movieBloc;
  late MovieBackdropBloc movieBackdropBloc;
  late MovieTabBloc movieTabBloc;
  late SearchMovieBloc searchMovieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = getItInstance<MovieBloc>();
    movieBackdropBloc = movieBloc.movieBackdropBloc;
    movieTabBloc = getItInstance<MovieTabBloc>();
    searchMovieBloc = getItInstance<SearchMovieBloc>();
    movieBloc.add(const LoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    movieBloc.close();
    movieBackdropBloc.close();
    movieTabBloc.close();
    searchMovieBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieBloc,
        ),
        BlocProvider(
          create: (context) => movieBackdropBloc,
        ),
        BlocProvider(
          create: (context) => movieTabBloc,
        ),
        BlocProvider(
          create: (context) => searchMovieBloc,
        ),
      ],
      child: Scaffold(
        drawer: const Drawer.NavigationDrawer(),
        body: BlocBuilder<MovieBloc, MovieState>(
          bloc: movieBloc,
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
                onPressed: () => movieBloc.add(
                  const LoadEvent(),
                ),
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
