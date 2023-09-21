import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/presentation/journeys/login/login_form.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_64.h),
              child: Logo(height: Sizes.dimen_48.h,),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
