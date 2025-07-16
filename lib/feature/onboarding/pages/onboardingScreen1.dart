import 'package:flutter/material.dart';
import 'package:mealapp/constant/Strings.dart';
import 'package:mealapp/constant/assets.dart';
import 'package:mealapp/constant/color.dart';
import 'package:mealapp/constant/text_style.dart';
import 'package:mealapp/feature/home/pages/home_screen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  late PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.backgroundImage,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            right: 50,
            bottom: 30,
            child: Container(
              padding: const EdgeInsets.all(43),
              alignment: Alignment.center,
              width: 313,
              height: 400,
              decoration: BoxDecoration(
                color: ColorConstant.primaryOrange.withOpacity(.9),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      children: [
                        buildOnboardingPage(
                          Strings.saveYourMealsIngredient,
                          Strings.addYourMealsAndItsIngredients,
                        ),
                        buildOnboardingPage(
                          Strings.useOurAppTheBestChoice,
                          Strings.theBestChoiceForYourKitchen,
                        ),
                        buildOnboardingPage(
                          Strings.ourAppYourUltimateChoice,
                          Strings.allTheBestRestaurantsAndTheirTopMenusAreReadyForYou,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: WormEffect(
                      dotWidth: 30,
                      dotHeight: 6,
                      activeDotColor: ColorConstant.primaryWhite,
                      dotColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentIndex < 2
                          ? TextButton(
                              onPressed: () {
                                controller.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Text(
                                "Skip",
                                style: TTextStyle.descriptionStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : const SizedBox(),
                        if(currentIndex<2) Spacer(),
                        
                      TextButton(
                        onPressed: () {
                          if (currentIndex < 2) {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          } 
                          
                        },
                        child: currentIndex < 2
                            ? Text(
                                "Next",
                                style: TTextStyle.descriptionStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            :  Center(
                              child: GestureDetector(
                                 onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),)),
                                child: Container(
                                  
                                   decoration:  BoxDecoration(
                                     borderRadius: BorderRadius.circular(100), 
                                      color:ColorConstant.primaryWhite,
                                   ),
                                   width: 50,
                                    height: 50,
                                   
                                   child:   Icon(Icons.arrow_forward, color: ColorConstant.primaryOrange,),
                                ),
                              ),
                            )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildOnboardingPage(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TTextStyle.headlineStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TTextStyle.descriptionStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
