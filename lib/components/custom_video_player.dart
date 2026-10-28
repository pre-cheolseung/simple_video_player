import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

// 동영상 재생기 위젯
class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  // XFile은 ImagePicker로 이미지 또는 영상을 선택했을 때 반환하는 타입
  final XFile video;

  const CustomVideoPlayer({
    required this.video,   // 상위에서 선택한 동영상 주입
    Key? key,
  }) : super(key: key);

  @override
  // State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
  State<CustomVideoPlayer> createState() {
    return _CustomVideoPlayerState();
  }
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Custom Video Player',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}