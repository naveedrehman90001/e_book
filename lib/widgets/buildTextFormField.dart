import 'package:e_book/utils/exports.dart';

TextFormField buildTextFormField({
  TextEditingController? controller,
  String? hintText,
  IconData? prefixIcon,
  required String? Function(String? val)? validate,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.grey.shade200,
    ),
    validator: validate,
  );
}
