import 'package:e_book/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = _firebaseAuth.currentUser;

      assert(currentUser!.uid == user!.uid);
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  // void signInUserFormValidation() {
  //   _loginFormKey.currentState!.save();
  //   if (_loginFormKey.currentState!.validate()) {
  //     return;
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppColors.kPrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Container(
            padding: kDefaultPadding,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Please enter your email',
                    prefixIcon: const Icon(Icons.email),
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
                const SizedBox(height: 30),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Please enter your password',
                    prefixIcon: const Icon(Icons.email),
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  validator: (value) {
                    if (!GetUtils.isLengthGreaterOrEqual(value, 6)) {
                      return 'Password must be 6 character or greater';
                    }
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.kPrimaryColor,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () async {
                    //TODO Call Login User Function
                    if (_loginFormKey.currentState!.validate()) {
                      // return;
                      try {
                        await _firebaseAuth
                            .signInWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            )
                            .then((value) => Get.offAll(() => HomeScreen()))
                            .catchError((e) {
                          Get.snackbar(
                            'Error while creating Account',
                            e.message!,
                            borderRadius: 5,
                          );
                        });
                      } on FirebaseAuthException catch (e) {
                        Get.snackbar(
                          'Error while Logging In',
                          e.message!,
                          borderRadius: 5,
                        );
                      }
                    }
                    // signInUser();
                    // Get.to(const HomeScreen())
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    //TODO add google sign in
                    signInWithGoogle();
                  },
                  child: const Text('G'),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have in Account? '),
                    InkWell(
                      //TODO
                      onTap: () => Get.to(SignUpScreen()),
                      child: const Text(
                        'SignUp',
                        style: kTitleTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
