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
      // children 위젯을 위로 쌓을 수 있는 위젯
      // List에 입력되는 순서대로 아래부터 쌓아 올려짐
      child: Stack(
        children: [
          // VideoPlayer 위젯을 Stack으로 이동
          VideoPlayer(
            videoPlayerController!,
          ),
          // child 위젯의 위치를 정할 수 있는 위젯 (여기서는 Slider 위젯)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // 동영상 재생 상태를 보여주는 슬라이더
            child: Slider(
              // value 매개변수는 현재 값을 의미
              value: videoPlayerController!.value.position.inSeconds.toDouble(),   // 현재 동영상 재생 위치를 초 단위로 표현
              // 슬라이더가 이동할 때마다 실행할 함수
              onChanged: (double val) {
                // 동영상의 재생 위치를 특정 위치로 이동
                videoPlayerController!.seekTo(
                  Duration(seconds: val.toInt()),   // val값을 int로 변경해서 Slider 위젯에서 입력된 재생 위치를 수신
                );
              },
              min: 0,
              // max 매개변수는 double 값을 입력
              max: videoPlayerController!.value.duration.inSeconds.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}