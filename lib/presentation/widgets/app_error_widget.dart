import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/presentation/blocs/movie/movie_cubit.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/presentation/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class AppErrorWidget extends StatefulWidget {
  final AppErrorType errorType;
  final Function() onPressed;

  const AppErrorWidget(
      {super.key, required this.errorType, required this.onPressed});

  @override
  _AppErrorWidgetState createState() => _AppErrorWidgetState();
}

class _AppErrorWidgetState extends State<AppErrorWidget> {
  bool _isConnected = true;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          _isConnected = false;
        });
      } else {
        setState(() {
          _isConnected = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.Sizes.dimen_20.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isConnected
                ? (widget.errorType == AppErrorType.api
                    ? TranslationConstants.somethingWentWrong.t(context)
                    : TranslationConstants.checkNetwork.t(context))
                : TranslationConstants.checkNetwork.t(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ButtonBar(
            children: [
              Button(
                onPressed: widget.onPressed,
                text: TranslationConstants.retry,
              ),
              Button(
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
                text: TranslationConstants.feedback,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
