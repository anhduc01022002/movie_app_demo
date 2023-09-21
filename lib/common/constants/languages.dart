import 'package:movie_app/domain/entities/language_entity.dart';

class Languages{
  const Languages._();

  static const languages = [
    LanguageEntity(value: 'English', code: 'en'),
    LanguageEntity(value: 'Vietnamese', code: 'vi'),
  ];
}