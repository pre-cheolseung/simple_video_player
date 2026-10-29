import 'dart:io';   // 파일 관련 작업 패키지

import 'package:flutter/material.dart';

import 'package:simple_video_player/components/custom_icon_button.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// 동영상 재생기 위젯
class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  // XFile은 ImagePicker로 이미지 또는 영상을 선택했을 때 반환하는 타입
  final XFile video;
  final GestureTapCallback onNewVideoPressed;   // 새로운 동영상을 선택하면 실행되는 함수

  const CustomVideoPlayer({
    required this.video,   // 상위에서 선택한 동영상 주입
    required this.onNewVideoPressed,

    Key? key,
  }) : super(key: key);

  @override
  // State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
  State<CustomVideoPlayer> createState() {
    return _CustomVideoPlayerState();
  }
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool showControls = false;   // 동영상을 조작하는 아이콘 숨김 여부

  VideoPlayerController? videoPlayerController;   // 동영상을 조작하는 컨트롤러

  @override
  void initState() {
    super.initState();

    initializeController();   // 컨트롤러 초기화
  }

  // 선택한 동영상으로 컨트롤러 초기화
  void initializeController() async {
    final videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoPlayerController.initialize();   // 동영상을 재생할 수 있는 상태로 준비

    videoPlayerController.addListener(videoPlayerControllerListener);   // 컨트롤러의 속성이 변경될 때마다 실행할 함수 등록

    // 상태 변경 시 setState() 함수 실행
    // 값 변경 시 build() 함수 재실행
    // Clean -> setState() -> Dirty -> build() -> Clean
    setState(() {
      this.videoPlayerController = videoPlayerController;
    });
  }

  // 동영상의 재생 상태가 변경될 때마다 setState()를 실행해서 build()를 재실행
  void videoPlayerControllerListener() {
    // 상태 변경 시 setState() 함수 실행
    // 값 변경 시 build() 함수 재실행
    // Clean -> setState() -> Dirty -> build() -> Clean
    setState(() {});
  }

  @override
  // didUpdateWidget() 함수를 사용해서 새로운 동영상이 선택되었을 때 videoPlayerController를 새로 생성
  // covariant 키워드는 CustomVideoPlayer 클래스에 상속된 값도 허가
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  // State가 폐기될 때 같이 폐기할 함수들을 실행
  @override
  void dispose() {
    videoPlayerController?.removeListener(videoPlayerControllerListener);   // Listener를 삭제하여 리소스 사용을 최적화

    super.dispose();
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

    // 화면 전체의 탭을 인식하기 위해 사용
    return GestureDetector(
      onTap: () {
        // 상태 변경 시 setState() 함수 실행
        // 값 변경 시 build() 함수 재실행
        // Clean -> setState() -> Dirty -> build() -> Clean
        setState(() {
          showControls = !showControls;
        });
      },
      // 동영상 비율에 따른 화면 렌더링
      child: AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        // children 위젯을 위로 쌓을 수 있는 위젯
        // List에 입력되는 순서대로 아래부터 쌓아 올려짐
        child: Stack(
          children: [
            // VideoPlayer 위젯을 Stack으로 이동
            VideoPlayer(
              videoPlayerController!,
            ),
            // 아이콘 버튼이 보일 때 화면을 어둡게 변경
            if (showControls)
              Container(
                color: Colors.black.withValues(alpha: 0.5),
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
            // showControls가 true일 때만 아이콘 보임
            if (showControls)
              // 새 동영상 선택 아이콘 오른쪽 상단에 위치
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: widget.onNewVideoPressed,   // 사진 및 카메라 아이콘을 선택하면 새로운 동영상 선택 함수 실행
                  iconData: Icons.photo_camera_back,
                ),
              ),
            // showControls가 true일 때만 아이콘 보임
            if (showControls)
              // 동영상 재생 관련 아이콘 중앙에 위치
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,   // 위젯들 간격을 동일하게 적용
                  children: [
                    // 되감기 버튼
                    CustomIconButton(
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    // 재생 중 여부에 따라 재생 또는 일시정지 버튼
                    CustomIconButton(
                      onPressed: onPlayPressed,
                      iconData: videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    // 앞으로 감기 버튼
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 되감기 버튼을 눌렀을 때 실행할 함수
  void onReversePressed() {
    final currentPosition = videoPlayerController!.value.position;   // 현재 동영상 재생 위치

    Duration position = Duration();   // 0초로 재생 위치 초기화

    // 현재 동영상 재생 위치가 3초보다 길 때만 3초 감소
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);   // 동영상의 재생 위치를 특정 위치로 이동
  }

  // 재생 또는 일시정지 버튼을 눌렀을 때 실행할 함수
  void onPlayPressed() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }

  // 앞으로 감기 버튼을 눌렀을 때 실행할 함수
  void onForwardPressed() {
    final maxPosition = videoPlayerController!.value.duration;   // 동영상 길이
    final currentPosition = videoPlayerController!.value.position;   // 현재 동영상 재생 위치

    Duration position = maxPosition;   // 동영상 길이로 재생 위치 초기화 (동영상 재생 종료 위치)

    // 동영상 길이에서 3초를 감소한 값보다 현재 재생 위치가 짧을 때만 3초 가산
    if ((maxPosition - Duration(seconds: 3)).inSeconds > currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);   // 동영상의 재생 위치를 특정 위치로 이동
  }
}