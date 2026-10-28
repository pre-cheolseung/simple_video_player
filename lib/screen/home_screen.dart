import 'package:flutter/material.dart';

import 'package:simple_video_player/widget/app_name.dart';
import 'package:simple_video_player/widget/logo.dart';

import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);   // const 생성자 : 최초 선언 후 변경 불가능한 빌드 타임 함수

  @override
  // State<HomeScreen> createState() => _HomeScreenState();
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;   // 동영상을 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: video == null ? renderEmpty() : renderVideo(),   // 동영상이 선택됐을 때와 선택되지 않았을 때 보여줄 위젯
    );
  }

  // 동영상 선택 전에 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,   // 최대 넓이로 설정
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,   // 위젯들 가운데 정렬
        children: [
          Logo(),   // 로고 이미지
          SizedBox(height: 30.0),
          AppName(),   // 앱 이름
        ],
      ),
    );
  }

  // 동영상 선택 후에 보여줄 위젯
  Widget renderVideo() {
    return Container();
  }
}