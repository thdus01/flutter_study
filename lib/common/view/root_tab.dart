import 'package:deliveryapp/common/const/colors.dart';
import 'package:deliveryapp/common/layout/default_layout.dart';
import 'package:deliveryapp/restaurant/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;  // controller 선언

  int index = 0;   // 초기 인덱스 값 0 설정

  @override
  void initState() {
    super.initState();

    // 몇 개의 화면을 컨트롤 할건지 설정 (length)
    // controller를 선언하는 현재 state 또는 statefulWidget을 넣어준다. (vsync)
    // vsync에 this 입력 시 with SingleTickerProviderStateMixin을 선언.
    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코드팩토리 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),   // 좌우 스크롤 방지
        controller: controller,
        children: [
          RestaurantScreen(),
          // Center(child: Container(child: Text('홈'))),
          Center(child: Container(child: Text('음식'))),
          Center(child: Container(child: Text('주문'))),
          Center(child: Container(child: Text('프로필'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,  // 아이템 클릭시 변화되는 색상
        unselectedItemColor: BODY_TEXT_COLOR,  // 아이템을 클릭하지 않을 때의 색상
        selectedFontSize: 10,  // 아이템 클릭 시 글자 크기
        unselectedFontSize: 10,  // 아이템 논클릭시 글자 크기
        type: BottomNavigationBarType.fixed,   // 타입 설정
        onTap: (int index) {   // 클릭 했을 때 어떤 인덱스 값인지 받음
          controller.animateTo(index);
        },
        currentIndex: index,  // 클릭한 인덱스 값을 바로 넣어줌
        items: const [  // 하단 navigation의 아이템
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
