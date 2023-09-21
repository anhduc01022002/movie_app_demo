import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:movie_app/presentation/blocs/login/login_bloc.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_expanded_list.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movie_app/presentation/journeys/favorite/favorite_screen.dart';
import 'package:movie_app/presentation/translation_constants.dart';
import 'package:movie_app/presentation/widgets/app_dialog.dart';
import 'package:movie_app/presentation/widgets/logo.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.Sizes.dimen_8.h,
                bottom: Sizes.Sizes.dimen_18.h,
                left: Sizes.Sizes.dimen_8.w,
                right: Sizes.Sizes.dimen_8.w,
              ),
              child: Logo(
                height: Sizes.Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
              title: TranslationConstants.favoriteMovies.t(context),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteList.favorite);
              },
            ),
            NavigationExpandedList(
                title: TranslationConstants.language.t(context),
                children: Languages.languages.map((e) => e.value).toList(),
                onPressed: (index) {
                  final language = Languages.languages[index];
                  print('Selected language: ${language.code}');
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ToggleLanguageEvent(language));
                }),
            NavigationListItem(
              title: TranslationConstants.feedback.t(context),
              onPressed: () async {
                const feedbackUrl =
                    'https://docs.google.com/forms/d/e/1FAIpQLSes60NYhSplFmklGv19xCo6Ec72PZqVb-JEHKL1PuXcfUQs5A/viewform?usp=sf_link';
                final url = Uri.parse(feedbackUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            NavigationListItem(
              title: TranslationConstants.about.t(context),
              onPressed: () {
                Navigator.of(context).pop();
                _showDialog(context);
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              listenWhen: (previous, current) => current is LogoutSuccess,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.initial, (route) => false);
              },
              child: NavigationListItem(
                title: TranslationConstants.logout.t(context),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      builder: (context) => AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          'assets/pngs/tmdb_logo.png',
          height: Sizes.Sizes.dimen_32.h,
        ),
      ),
      context: context,
    );
  }
}
