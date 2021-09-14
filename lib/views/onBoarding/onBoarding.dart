import 'package:e_book/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {

  final List<PageViewModel> listPageViewModel = [
    PageViewModel(
      title: 'Wellcome',
      body:
          'Reading is a valuable skill for acquiring knowledge, but it has many other important benefits. While engaged readers, young and old, are often aware of the knowledge they gain by reading a text, they may not be aware of all of the other valuable skills they are advancing at the same time.',
      image: Container(
          padding: EdgeInsets.only(top: Get.size.height * 0.04),
          child: Center(child: Image.asset('assets/images/onBoading2.jpg'))),
    ),
    PageViewModel(
      title: 'Reading Tips',
      body:
          'Reading is a valuable skill for acquiring knowledge, but it has many other important benefits. While engaged readers, young and old, are often aware of the knowledge they gain by reading a text, they may not be aware of all of the other valuable skills they are advancing at the same time.',
      image: Container(
          padding: EdgeInsets.only(top: Get.size.height * 0.04),
          child: Center(child: Image.asset('assets/images/onBoading1.png'))),
    ),
    PageViewModel(
      title: 'Books',
      body:
          'Reading is a valuable skill for acquiring knowledge, but it has many other important benefits. While engaged readers, young and old, are often aware of the knowledge they gain by reading a text, they may not be aware of all of the other valuable skills they are advancing at the same time.',
      image: Container(
          padding: EdgeInsets.only(top: Get.size.height * 0.04),
          child: Center(child: Image.asset('assets/images/onBoading2.jpg'))),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 45),
      child: IntroductionScreen(
        pages: listPageViewModel,
        showDoneButton: true,
        showSkipButton: true,
        skip: const Text('SkIP'),
        skipColor: AppColors.kPrimaryColor,
        onSkip: () => Get.offAll(LoginScreen()),
        skipFlex: 0,
        done: const Text('Done'),
        doneColor: AppColors.kPrimaryColor,
        onDone: () => Get.offAll(LoginScreen()),
        next: Text('Next'),
        nextColor: AppColors.kPrimaryColor,
        nextFlex: 0,
        dotsDecorator: DotsDecorator(
          color: Color(0xFFD3D3D3),
          activeSize: Size(23, 10),
          activeColor: AppColors.kPrimaryColor,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        globalBackgroundColor: Colors.white,
        // isProgressTap: false,
      ),
    );
  }
}
