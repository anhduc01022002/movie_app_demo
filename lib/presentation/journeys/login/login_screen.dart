import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/presentation/journeys/login/login_form.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_64.h),
              child: Logo(
                key: const ValueKey('logo_key'),
                height: Sizes.dimen_48.h,
              ),
            ),
            const Expanded(
              child: LoginForm(
                key: ValueKey('login_form_key'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}