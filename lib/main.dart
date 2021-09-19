import 'package:e_book/models/favoriteModel.dart';
import 'package:e_book/utils/exports.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

int? isViewed;
const String favorite = 'favorite';
const String favoriteId = 'favoriteId';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FavoriteModelAdapter());
  await Hive.openBox<FavoriteModel>(favorite);
  await Hive.openBox<String>(favoriteId);
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
              : MainScreen(),
    );
  }
}
