import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taafe/modules/search/search_cubit/search_cubit.dart';
import 'package:taafe/modules/search/search_cubit/search_state.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/network/remote/end_points.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) => Column(
          children: [
            searchKind(context, () {}, 'search', cubit),
            const SizedBox(
              height: SizeManager.s16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cubit.searchResult.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: SizeManager.s10),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl:
                          'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cubit.searchResult[index]['mainText'],
                        style: StylesManager.itemHome),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
