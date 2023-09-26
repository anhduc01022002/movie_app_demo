import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart' ;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEnabled
              ? [AppColor.royalBlue, AppColor.violet]
              : [Colors.grey, Colors.grey],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_20.w),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: Sizes.dimen_32.h,
      child: TextButton(
        key: const ValueKey('main_button'),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text.t(context),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //           colors: [
  //             AppColor.royalBlue,
  //             AppColor.violet,
  //           ],
  //       ),
  //       borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w),
  //       ),
  //     ),
  //     padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
  //     margin: EdgeInsets.symmetric(vertical: Sizes.dimen_12.h),
  //     child: TextButton(
  //         onPressed: onPressed,
  //         child: Text(
  //           text.t(context),
  //           style: Theme.of(context).textTheme.bodyMedium,
  //         ),
  //     ),
  //   );
  // }
}
