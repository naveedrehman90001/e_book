import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  // _storeLoginInfo() async {
  //   int isViewed = 1;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setInt('onBoarding', isViewed);
  // }

  final _firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conformPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.kPrimaryColor,
            ))
          : SingleChildScrollView(
              child: Form(
                key: _signUpFormKey,
                child: Container(
                  padding: kDefaultPadding,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      buildTextFormField(
                        controller: _nameController,
                        hintText: 'Please enter your name',
                        prefixIcon: Icons.person_outline,
                        validate: (String? value) {
                          if (!GetUtils.isLengthGreaterOrEqual(value, 3)) {
                            return 'Name must be 3 characters or greater';
                          }
                        },
                      ),
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
                            return 'Password must be 6 characters or greater';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      buildTextFormField(
                        controller: _conformPasswordController,
                        hintText: 'Please conform your password',
                        prefixIcon: Icons.lock_outlined,
                        validate: (String? value) {
                          if (!GetUtils.hasMatch(
                              value, _passwordController.text)) {
                            return 'Oop\'s password not match';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          //TODO Call Create User Function
                          if (_signUpFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await _firebaseAuth
                                  .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              )
                                  .then((value) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .set({
                                  'userId': FirebaseAuth
                                      .instance.currentUser!.uid
                                      .toString(),
                                  'name': _nameController.text,
                                  'email': _emailController.text.trim(),
                                }).catchError((e) {
                                  print(e.message!);
                                });
                              }).whenComplete(() async {
                                setState(() {
                                  isLoading = false;
                                });
                                await storeInfo(1);
                                Get.offAll(() => HomeScreen());
                              });
                            } on FirebaseAuthException catch (e) {
                              //TODO show snak bar
                              print(e.message!);
                            }
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Already have in Account? ',
                            style: kSubTitleTextStyle,
                          ),
                          InkWell(
                            onTap: () => Get.to(LoginScreen()),
                            child: const Text(
                              'Login',
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
