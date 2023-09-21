import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/domain/entities/movie_params.dart';
import 'package:movie_app/domain/entities/video_entity.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';

part 'videos_event.dart';

part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;

  VideosBloc({
    required this.getVideos,
  }) : super(VideosInitial()) {
    on<LoadVideosEvent>((event, emit) async {
      final Either<AppError, List<VideoEntity>> eitherVideoResponse =
          await getVideos(MovieParams(event.movieId));

      eitherVideoResponse.fold(
        (l) => emit(NoVideos()),
        (r) => emit(VideosLoaded(r)),
      );
    });
  }
}
