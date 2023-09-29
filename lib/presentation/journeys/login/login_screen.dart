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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            child: Image.asset(
              'assets/jpgs/poster_login.jpg', 
              fit: BoxFit.cover,
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LayoutBuilder(
              builder: (context, constraints){
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                    vertical: constraints.maxHeight * 0.05,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Logo(
                          key: const ValueKey('logo_key'),
                          height: Sizes.dimen_48.h,
                        ),
                        const LoginForm(
                          key: ValueKey('login_form_key'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}