import 'package:e_book/controllers/authController.dart';
import 'package:e_book/utils/exports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  final _firebaseAuth = FirebaseAuth.instance;

  // _storeHomeInfo() async {
  //   int isViewed = 0;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setInt('onBoarding', isViewed);
  // }

  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Book'),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  _authController.logoOutFromGoogle();
                  await _firebaseAuth.signOut().whenComplete(() async {
                    await storeInfo(0);
                    Get.offAll(const LoginScreen());
                  });
                } on FirebaseAuthException catch (e) {
                  Get.snackbar(
                    'Error while creating Account',
                    e.message!,
                    borderRadius: 5,
                  );
                }
              },
              icon: Icon(
                Icons.logout_outlined,
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: Image.network(
                      _authController.googleAccount.value?.photoUrl ?? '')
                  .image,
              radius: 50,
            ),
            Text(_authController.googleAccount.value?.displayName ?? ''),
            Text(_authController.googleAccount.value?.email ?? '')
          ],
        ),
      ),
    );
  }
}
