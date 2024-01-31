import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taafe/modules/onboarding/widget/onboarding_page.dart';
import 'package:taafe/modules/onboarding/widget/onboarding_skip.dart';
import 'package:taafe/shared/components/constants.dart';
import 'package:taafe/shared/resourses/assets_manager.dart';
import 'package:taafe/shared/resourses/color_manager.dart';
import 'package:taafe/shared/resourses/styles.dart';
import 'package:taafe/shared/resourses/value_app.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;

  int pageNum = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(SizeManager.s16),
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  pageNum = value;
                });
                pageController.animateToPage(value,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.bounceInOut);
              },
              children: [
                OnboardingPage(
                    image: AssetsManager.onboardingLogo3,
                    title: 'Psychology is the study',
                    content:
                        'Psychology is the study of mind and behavior.Its subject matter includes the behavior of humans'),
                OnboardingPage(
                    image: AssetsManager.onboardingLogo2,
                    title: 'Psychology is the study',
                    content:
                        'Psychology is the study of mind and behavior.Its subject matter includes the behavior of humans'),
                OnboardingPage(
                    image: AssetsManager.onboardingLogo1,
                    title: 'Psychology is the study',
                    content:
                        'Psychology is the study of mind and behavior.Its subject matter includes the behavior of humans')
              ],
            ),
            OnboardingSkip(),
            Positioned(
              bottom: SizeManager.s40,
              left: SizeManager.s20,
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                    activeDotColor: ColorManager.primaryColor,
                    dotHeight: SizeManager.s6),
              ),
            ),

            Positioned(
              bottom: SizeManager.s20,
              right: SizeManager.s2,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pageNum=pageNum+1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryColor,
                      shape: CircleBorder(),
                  ),
                  child: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: SizeManager.s20,)),
            )
          ],
        ),
      ),
    );
  }
}
