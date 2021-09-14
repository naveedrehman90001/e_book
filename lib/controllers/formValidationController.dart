import 'package:e_book/utils/exports.dart';

class FormValidationController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpUser = GlobalKey<FormState>();

  // TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // late TextEditingController passwordController;
  // late TextEditingController confirmPasswordController;

  var name;
  var email;
  var password;
  var confromPassword;

  // @override
  // void onInit() {
  //   super.onInit();
  //   nameController = TextEditingController();
  //   // emailController = TextEditingController();
  //   passwordController = TextEditingController();
  //   confirmPasswordController = TextEditingController();
  // }
  //
  // @override
  // void onClose() {
  //   super.onClose();
  //   nameController.dispose();
  //   // emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  // }

  String? validateName(String value) {
    if (!GetUtils.isGreaterThan(0, 3)) {
      return 'Name must be greater then 3 characters';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Please provide a valid email';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be 6 character or greater';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (password.compareTo(confromPassword)) {
      return 'Password not match';
    }
    return null;
  }

  void signInUser() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }

  void RegisterUser() {
    final isValid = signUpUser.currentState!.validate();
    if (!isValid) {
      return;
    }
    signUpUser.currentState!.save();
  }

  //
}
