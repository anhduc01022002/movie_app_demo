import 'package:movie_app/common/constants/translation_constants.dart';

class Tab {
  final String title;
  final int index;

  const Tab({required this.title, required this.index});
}

class MovieTabConstants {
  static const List<Tab> movieTabs = [
    Tab(title: TranslationConstants.popular, index: 0),
    Tab(title: TranslationConstants.now, index: 1),
    Tab(title: TranslationConstants.soon, index: 2),
  ];
}
