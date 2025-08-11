
import 'package:flutter/cupertino.dart';

class LogoBanner extends StatelessWidget {
  final double width;
  final double height;

  const LogoBanner({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo/logo.png',
        width: width,
        height: height,
      ),
    );
  }
}