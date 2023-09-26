import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movie_app/presentation/blocs/theme/theme_cubit.dart';
import 'package:movie_app/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';
import 'package:movie_app/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().statusBarHeight + Sizes.Sizes.dimen_4.h,
        left: Sizes.Sizes.dimen_16.w,
        right: Sizes.Sizes.dimen_16.w,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              const IconData(0xe3dc, fontFamily: 'MaterialIcons'),
              size: Sizes.Sizes.dimen_18.h,
              color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white : AppColor.vulcan,
            ),
          ),
          const Expanded(
            child: Logo(
              height: Sizes.Sizes.dimen_24,
            ),
          ),
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    BlocProvider.of<SearchMovieCubit>(context),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                color: context.read<ThemeCubit>().state == Themes.dark ? Colors.white : AppColor.vulcan,
                size: Sizes.Sizes.dimen_18.h,
              )),
        ],
      ),
    );
  }
}
