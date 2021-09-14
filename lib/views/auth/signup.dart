import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  final _firebaseAuth = FirebaseAuth.instance;

  final _user = FirebaseAuth.instance.currentUser;

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
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Please enter your name',
                          prefixIcon: const Icon(Icons.person_outline),
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (!GetUtils.isLengthGreaterOrEqual(value, 3)) {
                            return 'Name must be 3 characters or greater';
                          }
                        },
                      ),
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
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Please enter your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (!GetUtils.isLengthGreaterOrEqual(value, 6)) {
                            return 'Password must be 6 characters or greater';
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _conformPasswordController,
                        decoration: InputDecoration(
                          hintText: 'Please conform your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (!GetUtils.hasMatch(
                              value, _passwordController.text)) {
                            return 'Oop\'s password not match';
                          }
                        },
                      ),
                      const SizedBox(height: 30),
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
                                password: _passwordController.text.trim(),
                              )
                                  .then((value) {
                                usersCollection.add({
                                  'name': _nameController.text,
                                  'email': _emailController.text,
                                }).then(
                                    (value) => Get.offAll(() => HomeScreen())).catchError((e){
                                  print(e.message!);
                                });
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
