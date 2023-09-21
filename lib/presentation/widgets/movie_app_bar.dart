import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/journeys/search_movie/custom_search_movie_delegate.dart';
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
              color: Colors.white,
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
                    BlocProvider.of<SearchMovieBloc>(context),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: Sizes.Sizes.dimen_18.h,
              )),
        ],
      ),
    );
  }
}
