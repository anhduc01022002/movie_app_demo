import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart' as Sizes;
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/data/core/api_constants.dart';
import 'package:movie_app/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app/presentation/themes/theme_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(
      builder: (context, state) {
        if (state is CastLoaded) {
          return Container(
            height: Sizes.Sizes.dimen_150.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.casts.length,
              itemBuilder: (context,index){
                final castEntity = state.casts[index];
                return Container(
                  height: Sizes.Sizes.dimen_150.h,
                  width: Sizes.Sizes.dimen_150.w,
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(
                      horizontal: Sizes.Sizes.dimen_8.w,
                      vertical: Sizes.Sizes.dimen_4.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.Sizes.dimen_8.w),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.w),
                            ),
                            child: CachedNetworkImage(
                              height: Sizes.Sizes.dimen_100.h,
                              width: Sizes.Sizes.dimen_150.w,
                              imageUrl:
                                  '${ApiConstants.BASE_IMAGE_URL}${castEntity.posterPath}',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.Sizes.dimen_8.w,
                          ),
                          child: Text(
                            castEntity.name,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.vulcanBodyText2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Sizes.Sizes.dimen_8.w,
                            right: Sizes.Sizes.dimen_8.w,
                            bottom: Sizes.Sizes.dimen_2.h,
                          ),
                          child: Text(
                            castEntity.character,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
