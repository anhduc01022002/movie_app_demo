import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:movie_app/presentation/translation_constants.dart';
import 'package:movie_app/presentation/widgets/button.dart';

class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget image;

  const AppDialog({
      super.key,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.vulcan,
      elevation: Sizes.Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.Sizes.dimen_32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.Sizes.dimen_8.w),
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: Sizes.Sizes.dimen_4.h,
            left: Sizes.Sizes.dimen_16.w,
            right: Sizes.Sizes.dimen_16.w,
          ),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColor.vulcan,
                blurRadius: Sizes.Sizes.dimen_40,
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.t(context),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.Sizes.dimen_6.h),
                child: Text(
                  description.t(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if(image != null)
                SizedBox(
                  height: Sizes.Sizes.dimen_100.h,
                  width: Sizes.Sizes.dimen_100.w,
                  child: image,
                ),
              Button(
                  text: TranslationConstants.okay,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
