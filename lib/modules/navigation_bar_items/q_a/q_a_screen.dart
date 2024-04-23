import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/strings_manager.dart';
import '../../../shared/resourses/value_app.dart';

class QAScreen extends StatelessWidget {
  const QAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(
              left: SizeManager.s24, right: SizeManager.s22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringManager.qA,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: SizeManager.s20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(
                  //     child: searchKind(context, () {}, StringManager.search,
                  //         right: SizeManager.s0, left: SizeManager.s0)),
                  const SizedBox(
                    width: SizeManager.s16,
                  ),
                  floatingButton(
                      null,
                      const Icon(
                        Icons.add,
                        color: ColorManager.headOrange,
                      ))
                ],
              ),
              const SizedBox(
                height: SizeManager.s20,
              ),
              titleRow(StringManager.sort),
              const SizedBox(
                height: SizeManager.s20,
              ),
            ],
          ),
        )),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(SizeManager.s10),
            child: listViewQAV(
                'I feel anxious always and moody and feel lonely, sometimes i think in suiside ',
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam Lorem ipsum dolor sit amet, consectetur adipisicing Lorem ipsum dolor sit amet,',
                'Mazin Asaad',
                'The head of psychology department - alex university'),
          ),
        )
      ],
    );
  }
}
