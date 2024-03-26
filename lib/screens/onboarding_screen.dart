import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/models/onboard_model.dart';
import 'package:news_feed/screens/dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardModel> onboardList = [
    OnboardModel(
        text: 'Stay informed: Get notified about the news that matters to you',
        image: '${assetImagePath}ob_one.png',
        dots: '${assetImagePath}ob_one_dots.svg'),
    OnboardModel(
        text: 'Tailor your news feed. Share and save articles you care about.',
        image: '${assetImagePath}ob_two.png',
        dots: '${assetImagePath}ob_two_dots.svg'),
  ];

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: pageController,
        itemCount: onboardList.length,
        itemBuilder: (context, index) => Column(children: [
          SizedBox(
            height: mq.height * .7,
            width: double.maxFinite,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/newspaper.png', fit: BoxFit.cover),
                Align(
                  child: Image.asset(
                    onboardList[index].image,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          SvgPicture.asset(onboardList[index].dots),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(onboardList[index].text,
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ),
          ElevatedButton(
            onPressed: () {
              if (index < onboardList.length - 1) {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen()));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text('Next',
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
