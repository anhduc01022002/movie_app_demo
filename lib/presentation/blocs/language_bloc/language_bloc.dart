import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/domain/entities/language_entity.dart';
import 'package:movie_app/domain/entities/no_params.dart';
import 'package:movie_app/domain/usecases/get_preferred_language.dart';
import 'package:movie_app/domain/usecases/update_language.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;

  LanguageBloc({
    required this.getPreferredLanguage,
    required this.updateLanguage,
  }) : super(LanguageLoaded(Locale(Languages.languages[0].code))) {

    on<ToggleLanguageEvent>((event, emit) async {
      await updateLanguage(event.language.code);
      final response = await getPreferredLanguage(NoParams());

      response.fold(
            (l) => emit(LanguageError()),
            (r) => emit(LanguageLoaded(Locale(r))),
      );
    });
    on<LoadPreferredLanguageEvent>((event, emit) async {
      final response = await getPreferredLanguage(NoParams());

      response.fold(
            (l) => emit(LanguageError()),
            (r) => emit(LanguageLoaded(Locale(r))),
      );
    });
  }
}
