import 'package:e_book/utils/exports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Book'),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await _firebaseAuth
                      .signOut()
                      .whenComplete(() => Get.offAll(LoginScreen()));
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
    );
  }
}
