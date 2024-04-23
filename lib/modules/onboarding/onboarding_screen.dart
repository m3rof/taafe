import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taafe/layout/home/home_screen.dart';
import 'package:taafe/modules/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'package:taafe/modules/onboarding/onboarding_cubit/onboarding_state.dart';
import 'package:taafe/modules/onboarding/widget/hobby_screen.dart';
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

  int lastPage = 0;

  bool isLast = false;

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
    var cubit = OnBoardingCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(SizeManager.s16),
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    if (value == 3) {
                      isLast = true;
                      cubit.hobbyLocal.forEach((element) {
                        cubit.sendHobby(1, element);
                      });
                    } else {
                      isLast = false;
                    }
                  });
                  pageController.animateToPage(value,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeIn);
                },
                children: [
                  const OnboardingPage(
                      image: AssetsManager.onboardingLogo3,
                      title: 'Psychology is the study',
                      content:
                          'Psychology is the study of mind and behavior.Its subject matter includes the behavior of humans'),
                  const OnboardingPage(
                      image: AssetsManager.onboardingLogo2,
                      title: 'Psychology is the study',
                      content:
                          'Psychology is the study of mind and behavior.Its subject matter includes the behavior of humans'),
                  HobbyScreen(cubit),
                  const OnboardingPage(
                      image: AssetsManager.onboardingLogo1,
                      title: 'Psychology is the study',
                      content:
                          'Psychology is the study of mind and behavior.Its subject matter includes the behavior of humans'),
                ],
              ),
              OnboardingSkip(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 4,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: ColorManager.primaryColor,
                          dotHeight: SizeManager.s6),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        });
                        if (isLast)
                          return moveScreen(
                              context: context, screen: const HomeScreen());
                      },
                      child: Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: SizeManager.s4),
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryColor,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: SizeManager.s20,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
