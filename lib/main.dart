import 'package:e_book/utils/exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  isViewed = sharedPreferences.getInt('onBoarding');
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
      home: isViewed != 0 && isViewed != 1
          ? OnBoardingScreen()
          : isViewed == 0 && isViewed != 1
              ? const LoginScreen()
              : HomeScreen(),
    );
  }
}
