
import 'package:flutter/material.dart';
import 'package:taafe/shared/components/components.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import '../../../shared/resourses/value_app.dart';

class TherapistsScreen extends StatelessWidget {
  const TherapistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                titleKind(context, StringManager.therapists),
                // searchKind(context, (){}, '${StringManager.therapists} ${StringManager.searchHint}'),
                const SizedBox(height: SizeManager.s14,),
                Padding(
                padding: const EdgeInsets.only(left: SizeManager.s24, right: SizeManager.s22),
                child: titleRow(context,'',(){},StringManager.filter),
                ),
                const SizedBox(height: SizeManager.s18),
                ],
                ) ,
        ),
        SliverToBoxAdapter(
          child:listViewTherapistsV(context),
        )
      ],
    );
  }
}

