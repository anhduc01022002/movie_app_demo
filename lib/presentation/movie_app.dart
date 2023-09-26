import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/blocs/language_bloc/language_cubit.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';
import 'package:movie_app/presentation/blocs/login/login_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/fade_page_route_.dart';
import 'package:movie_app/presentation/journeys/loading/loading_screen.dart';
import 'package:movie_app/presentation/routes.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageCubit _languageCubit;
  late LoginCubit _loginBloc;
  late LoadingCubit _loadingCubit;
  late ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _languageCubit = getItInstance<LanguageCubit>();
    _languageCubit.loadPreferredLanguage();
    _loginBloc = getItInstance<LoginCubit>();
    _loadingCubit = getItInstance<LoadingCubit>();
    _themeCubit = getItInstance<ThemeCubit>();
    _themeCubit.loadPreferredTheme();
  }

  @override
  void dispose() {
    _languageCubit.close();
    _loginBloc.close();
    _loadingCubit.close();
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>.value(
          value: _languageCubit,
        ),
        BlocProvider<LoginCubit>.value(
          value: _loginBloc,
        ),
        BlocProvider<LoadingCubit>.value(
          value: _loadingCubit,
        ),
        BlocProvider<ThemeCubit>.value(
          value: _themeCubit,
        ),
      ],
      child: BlocBuilder<ThemeCubit, Themes>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Movie App',
              theme: ThemeData(
                unselectedWidgetColor: AppColor.royalBlue,
                primaryColor: theme == Themes.dark ? AppColor.vulcan : Colors.white,
                scaffoldBackgroundColor: theme == Themes.dark ? AppColor.vulcan : Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: theme == Themes.dark
                    ? ThemeText.getTextTheme()
                    : ThemeText.getLightTextTheme(),
                brightness: theme == Themes.dark
                    ? Brightness.dark
                    : Brightness.light,
                appBarTheme: const AppBarTheme(elevation: 0),
                cardTheme: CardTheme(
                  color:
                  theme == Themes.dark ? Colors.white : AppColor.vulcan,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: Theme.of(context).textTheme.greySubtitle1,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: theme == Themes.dark ? Colors.white : AppColor.vulcan,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              supportedLocales:
                Languages.languages.map((e) => Locale(e.code)).toList(),
              locale: locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                return LoadingScreen(
                  screen: child ?? const SizedBox.shrink(),
                );
              },
              initialRoute: RouteList.initial,
              onGenerateRoute: (RouteSettings settings) {
                final routes = Routes.getRoutes(settings);
                final WidgetBuilder builder =
                    routes[settings.name] ??
                            (context) => const SizedBox.shrink();
                return FadePageRouteBuilder(
                  builder: builder,
                  settings: settings,
                );
              },
            );
          });
        },
      ),
    );
  }
}
