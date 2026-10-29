import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;   // 아이콘을 눌렀을 때 실행할 함수
  final IconData iconData;   // 아이콘

  const CustomIconButton({
    required this.onPressed,
    required this.iconData,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 아이콘을 버튼으로 만들어주는 위젯
    return IconButton(
      color: Colors.white,   // 아이콘 색상
      onPressed: onPressed,   // 아이콘을 눌렀을 때 실행할 함수
      // 아이콘
      icon: Icon(
        iconData,
      ),
      iconSize: 30.0,   // 아이콘 크기
    );
  }
}