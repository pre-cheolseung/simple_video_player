import 'package:flutter/material.dart';

// 로고를 보여줄 위젯
class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/logo.png',   // 로고 이미지
    );
  }
}