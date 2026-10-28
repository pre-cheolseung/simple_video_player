import 'dart:io';   // 파일 관련 작업 패키지

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? videoPlayerController;   // 동영상을 조작하는 컨트롤러

  @override
  void initState() {
    super.initState();

    initializeController();   // 컨트롤러 초기화
  }

  // 선택한 동영상으로 컨트롤러 초기화
  initializeController() async {
    final videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoPlayerController.initialize();

    setState(() {
      this.videoPlayerController = videoPlayerController;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoPlayerController == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCDB3FF)),   // 색상 지정
        ),
      );
    }

    // 동영상 비율에 따른 화면 렌더링
    return AspectRatio(
      aspectRatio: videoPlayerController!.value.aspectRatio,
      child: VideoPlayer(
        videoPlayerController!,
      ),
    );
  }
}