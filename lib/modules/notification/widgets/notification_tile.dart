
import 'package:flutter/material.dart';

import '../../../shared/resourses/color_manager.dart';
import '../../../shared/resourses/styles.dart';
import '../../../shared/resourses/value_app.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitle,date;
  final onTap;
  final bool seen;


  NotificationTiles({required this.title,required this.subtitle,required this.onTap,required this.seen,required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(left: SizeManager.s20, right: SizeManager.s22),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                seen?Icon(Icons.notifications_none_outlined):Icon(Icons.notifications_active_outlined,),
                const SizedBox(
                  width: SizeManager.s30,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(SizeManager.s6),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(SizeManager.s16)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: StylesManager.itemHome.copyWith(
                              fontSize: SizeManager.s20,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: SizeManager.s8,
                        ),
                        Text(
                          subtitle,
                          style: StylesManager.itemHome
                              .copyWith(fontSize: SizeManager.s16),
                        ),
                        SizedBox(
                          height: SizeManager.s8,
                        ),
                        Row(
                          children: [
                            Text(
                              '2023-11-05',
                              style: StylesManager.or,
                            ),
                            const SizedBox(
                              width: SizeManager.s8,
                            ),
                            ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}