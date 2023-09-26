import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class SizeConfig {
  static double heightMultiplier = 3.0;
}

class Logo extends StatelessWidget {
  final double height;

  const Logo({
    Key? key,
    required this.height
  }) :  assert(height > 0, 'height should be greater than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      key: const ValueKey('logo_image_key'),
      color: context.read<ThemeCubit>().state == Themes.dark
          ? Colors.white
          : AppColor.vulcan,
      height: height.h,
    );
  }
}
