import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/languages.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/di/get_it.dart';
import 'package:movie_app/presentation/app_localizations.dart';
import 'package:movie_app/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:movie_app/presentation/blocs/login/login_bloc.dart';
import 'package:movie_app/presentation/fade_page_route_.dart';
import 'package:movie_app/presentation/routes.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late LanguageBloc _languageBloc;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _loginBloc = getItInstance<LoginBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(
          value: _languageBloc,
        ),
        BlocProvider<LoginBloc>.value(
          value: _loginBloc,
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Movie App',
              theme: ThemeData(
                unselectedWidgetColor: AppColor.royalBlue,
                primaryColor: AppColor.vulcan,
                scaffoldBackgroundColor: AppColor.vulcan,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: ThemeText.getTextTheme(),
                appBarTheme: const AppBarTheme(elevation: 0),
              ),
              supportedLocales:
                  Languages.languages.map((e) => Locale(e.code)).toList(),
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                return child ?? const SizedBox.shrink();
              },
              initialRoute: RouteList.initial,
              onGenerateRoute: (RouteSettings settings) {
                final routes = Routes.getRoutes(settings);
                final WidgetBuilder builder = routes[settings.name] ??
                    (context) => const SizedBox.shrink();
                return FadePageRouteBuilder(
                  builder: builder,
                  settings: settings,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
