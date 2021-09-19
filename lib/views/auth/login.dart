import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/controllers/authController.dart';
import 'package:e_book/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  // _storeLoginInfo() async {
  //   int isViewed = 1;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setInt('onBoarding', isViewed);
  // }

  final _authController = Get.put(AuthController());

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final User? user = FirebaseAuth.instance.currentUser;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppColors.kPrimaryColor,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
                backgroundColor: Colors.transparent,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
                child: Container(
                  padding: kDefaultPadding,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      buildTextFormField(
                        controller: _emailController,
                        hintText: 'Please enter your email',
                        prefixIcon: Icons.email,
                        validate: (String? value) {
                          if (!GetUtils.isEmail(value!)) {
                            return 'Please provide a valid email';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      buildTextFormField(
                        controller: _passwordController,
                        hintText: 'Please enter your password',
                        prefixIcon: Icons.lock_outlined,
                        validate: (String? value) {
                          if (!GetUtils.isLengthGreaterOrEqual(value, 6)) {
                            return 'Password must be 6 character or greater';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => ForgotScreen());
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.kPrimaryColor,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () async {
                          //TODO Call Login User Function
                          if (_loginFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await _firebaseAuth
                                  .signInWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              )
                                  .then((value) async {
                                await storeInfo(1);
                                Get.offAll(() => MainScreen());
                              }).catchError((e) {
                                Get.snackbar(
                                  'Error while Logging In to Account',
                                  e.message!,
                                  borderRadius: 5,
                                );
                              }).whenComplete(() {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            } on FirebaseAuthException catch (e) {
                              // Get.snackbar(
                              //   'Error while Logging In',
                              //   e.message!,
                              //   borderRadius: 5,
                              // );
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
                        onPressed: () async {
                          //TODO add google sign in
                          try {
                            await _authController.logInWithGoogle();
                            if (_authController.googleAccount.value != null) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                'userId':
                                    _authController.googleAccount.value?.id ??
                                        '',
                                'image': _authController
                                        .googleAccount.value?.photoUrl ??
                                    '',
                                'name': _authController
                                        .googleAccount.value?.displayName ??
                                    '',
                                'email': _authController
                                        .googleAccount.value?.email ??
                                    '',
                              }).catchError((e) {
                                print(e.message!);
                              });
                              await storeInfo(1);
                              Get.offAll(() => MainScreen());
                            }
                          } catch (e) {
                            // print(e.toString);
                          }
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
