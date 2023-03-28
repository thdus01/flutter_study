import 'package:deliveryapp/common/component/custom_test_form_field.dart';
import 'package:deliveryapp/common/view/splash_screen.dart';
import 'package:deliveryapp/user/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,  // debug 배너 숨기기
      home: SplashScreen(),
    );
  }
}


