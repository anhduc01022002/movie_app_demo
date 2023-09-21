import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class Separator extends StatelessWidget {
  const Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.Sizes.dimen_1.h,
      width: Sizes.Sizes.dimen_80.w,
      padding: EdgeInsets.only(
        top: Sizes.Sizes.dimen_2.h,
        bottom: Sizes.Sizes.dimen_6.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.Sizes.dimen_1.h)),
        gradient: const LinearGradient(
          colors: [
            AppColor.violet,
            AppColor.royalBlue,
          ],
        ),
      ),
    );
  }
}
