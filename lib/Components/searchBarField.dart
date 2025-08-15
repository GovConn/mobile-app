import 'package:flutter/material.dart';
import '../theme/color_theme.dart';

class SearchBarField extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap; // Makes the whole field tappable for selection
  final TextEditingController?
      controller; // Optional controller for actual input

  const SearchBarField({
    Key? key,
    required this.hintText,
    this.onTap,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap for selection
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(50.0), // Rounded corners for pill shape
          border: Border.all(color: greyTextColor.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AbsorbPointer(
          // Prevents direct text input if onTap is used for selection
          absorbing: onTap != null,
          child: TextField(
            controller: controller,
            readOnly: onTap != null, // Make read-only if onTap is provided
            textAlign: TextAlign.start, // Align text to start
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: blackPrimary),
              border: InputBorder.none, // Remove default TextField border
              suffixIcon: const Icon(Icons.search,
                  color: greyTextColor), // Moved icon to suffix
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: 15.0), // Added horizontal padding
            ),
            style: const TextStyle(color: blackPrimary),
          ),
        ),
      ),
    );
  }
}
