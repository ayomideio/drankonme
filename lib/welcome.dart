import 'package:dranksonme/get-started.dart';
import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int currentIndex = 1;

  void handleIndexChange() {
    currentIndex == 3
        ? setState(() {
            currentIndex = 1;
          })
        : setState(() {
            currentIndex = currentIndex + 1;
          });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            currentIndex == 1
                ? Image.asset(
                    "assets/vectors/IMG_8507.PNG",
                    height: screenSize.height / 3,
                  )
                : currentIndex == 2
                    ? Image.asset(
                        "assets/vectors/IMG_8508.PNG",
                        height: screenSize.height / 3,
                      )
                    : currentIndex == 3
                        ? Image.asset(
                            "assets/vectors/drank-3.png",
                            height: screenSize.height / 3,
                          )
                        : Image.asset(
                            "assets/vectors/pana.png",
                            height: screenSize.height / 3,
                          ),
            SizedBox(height: screenSize.height / 15),
            Container(
              width: screenSize.width / 1.1,
              height: 200,
              child: currentIndex == 1
                  ? onBoardContent(OnBoardingText.title1,
                      OnBoardingText.subTitle1, OnBoardingText.lastTitle1)
                  : currentIndex == 2
                      ? onBoardContent(OnBoardingText.title2,
                          OnBoardingText.subTitle2, OnBoardingText.lastTitle2)
                      : currentIndex == 3
                          ? onBoardContent(
                              OnBoardingText.title3,
                              OnBoardingText.subTitle3,
                              OnBoardingText.lastTitle3)
                          : SizedBox(
                              height: 0,
                            ),
            ),
            currentIndex == 3
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (buildContext) => GetStarted()));
                    },
                    child: Container(
                      width: screenSize.width / 1.1,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorStyles.primaryButtonColor,
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: ColorStyles.screenColor),
                        ),
                      ),
                    ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Skip",
                        style: TextStyle(
                            color: Color(0xff323232),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: screenSize.width / 20,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: currentIndex == 1
                                ? ColorStyles.primaryButtonColor
                                : ColorStyles.primaryButtonColor.withOpacity(0.2),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: currentIndex == 2
                               ? ColorStyles.primaryButtonColor
                                : ColorStyles.primaryButtonColor.withOpacity(0.2),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: currentIndex == 3
                               ? ColorStyles.primaryButtonColor
                                : ColorStyles.primaryButtonColor.withOpacity(0.2),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenSize.width / 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          handleIndexChange();
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: ColorStyles.primaryButtonColor,
                          child: Icon(
                            Icons.arrow_forward,
                            color: ColorStyles.screenColor,
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

  Widget onBoardContent(String title, String subTitle, String lastTitle) {
    return Column(children: [
      Text(
        title,
        style: TextStyle(
            color: Color(0xff323232),
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        subTitle,
        style: TextStyle(
          color: Color(0xff323232),
          fontSize: 12,
        ),
      ),
      Text(
        lastTitle,
        style: TextStyle(
          color: Color(0xff323232),
          fontSize: 12,
        ),
      ),
    ]);
  }
}
