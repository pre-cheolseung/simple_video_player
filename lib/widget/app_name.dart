import 'package:flutter/material.dart';

// 앱 제목을 보여줄 위젯
class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,   // 가운데 정렬
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,   // textStyle에서 두께만 700으로 변경
          ),
        ),
      ],
    );
  }
}