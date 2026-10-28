import 'package:flutter/material.dart';

// 로고를 보여줄 위젯
class Logo extends StatelessWidget {
  final GestureTapCallback onTap;   // 탭 했을 때 실행할 함수

  const Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,   // 상위 위젯으로부터 탭 콜백 수신
      child: Image.asset(
        'assets/img/logo.png',   // 로고 이미지
      ),
    );
  }
}