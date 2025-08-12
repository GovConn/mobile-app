import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/color_theme.dart';

class OTPBox extends StatelessWidget {
  const OTPBox({
    super.key,
    required this.context,
    this.controller
  });

  final BuildContext context;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: 45,
    height: 50,
    child: TextField(
      maxLength: 1, 
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(color: blackPrimary, fontSize: 20),
      decoration: InputDecoration(
        counterText: '', 
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: greyTextColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: blackPrimary, width: 2),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, 
      ],
      onChanged: (value) {
        if (value.length == 1) {         
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}
}
