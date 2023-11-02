import 'package:flutter/material.dart';
import 'package:taafe/shared/resourses/strings_manager.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/resourses/value_app.dart';

class MyTherapistsScreen extends StatelessWidget {
  const MyTherapistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height:
                          hightMedia(context: context, h: SizeManager.s_03)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: SizeManager.s24, right: SizeManager.s22),
                    child: Text(
                      StringManager.myTherapists,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: SizeManager.s28),
                    ),
                  ),
                  SizedBox(
                      height:
                          hightMedia(context: context, h: SizeManager.s_05)),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: SizeManager.s24, right: SizeManager.s22),
                    child: Text(
                      StringManager.onlineTherapists,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: SizeManager.s20),
                    ),
                  ),
                  SizedBox(
                      height:
                          hightMedia(context: context, h: SizeManager.s_05)),
                  SizedBox(
                    height: SizeManager.s170,
                    child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return onlineTherapists();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: SizeManager.s24, right: SizeManager.s22),
                    child: Text(
                      'Recent therapists',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: SizeManager.s20),
                    ),
                  ),

                ],
              ),
            ),
            SliverToBoxAdapter(
              child: listViewTherapistsV(context),
            )
          ],
        ));
  }
}
