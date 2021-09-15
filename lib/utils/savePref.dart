import 'package:shared_preferences/shared_preferences.dart';

storeInfo(int? viewed) async {
  int isViewed = viewed!;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setInt('onBoarding', isViewed);
}
