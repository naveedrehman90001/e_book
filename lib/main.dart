import 'package:e_book/utils/exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.kPrimaryColor,
        scaffoldBackgroundColor: AppColors.kWhiteColor,
      ),
      home: SplashScreen(),
    );
  }
}
