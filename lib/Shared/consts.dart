import 'package:flutter/material.dart';

class MyColors {
  static const Color mainColor = Color(0xff598216);
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String hintText,
  required String labelText,
  required IconData icon,
  required String? Function(String?) validator,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      controller: controller,
      validator: validator,

      decoration: buildInputDecoration(hintText, labelText, icon),
    ),
  );
}


InputDecoration buildInputDecoration(
    String hintText, String labelText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: MyColors.mainColor),
    hintText: hintText,
    labelText: labelText,
    filled: true,
    floatingLabelStyle:
    const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
    fillColor: Colors.grey[200],
    contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: MyColors.mainColor, width: 2),
    ),
    labelStyle:
        const TextStyle(color: MyColors.mainColor, fontWeight: FontWeight.bold),
  );
}
