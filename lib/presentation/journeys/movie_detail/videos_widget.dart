import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/videos/videos_bloc.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_arguments.dart';
import 'package:movie_app/presentation/journeys/watch_video/watch_video_screen.dart';
import 'package:movie_app/presentation/translation_constants.dart';
import 'package:movie_app/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc videosBloc;

  const VideosWidget({
    super.key,
    required this.videosBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: videosBloc,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteList.watchTrailer,
                arguments: WatchVideoArguments(videos),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
