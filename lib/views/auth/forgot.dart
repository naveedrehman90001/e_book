import 'package:e_book/utils/exports.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _forgotFormKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Form(
        key: _forgotFormKey,
        child: Container(
          padding: kDefaultPadding,
          child: Column(children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Please enter your email',
                prefixIcon: const Icon(Icons.email_outlined),
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return 'Please provide a valid email';
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  //TODO Forgot password functionality

                  if (_forgotFormKey.currentState!.validate()) {
                    try {
                      _firebaseAuth.sendPasswordResetEmail(
                          email: _emailController.text);
                      Get.back();
                      Get.snackbar(
                        "Please Verify Your Email",
                        "Go to your email ${_emailController.text}",
                        duration: Duration(seconds: 5),
                        borderRadius: 10,
                        icon: Icon(Icons.lock_open, color: Colors.white),
                      );
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: const Text('Send')),
          ]),
        ),
      ),
    );
  }
}
