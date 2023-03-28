import 'package:deliveryapp/common/const/colors.dart';
import 'package:deliveryapp/common/const/data.dart';
import 'package:deliveryapp/common/layout/default_layout.dart';
import 'package:deliveryapp/common/view/root_tab.dart';
import 'package:deliveryapp/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/common/const/data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    //deleteToken();
    checkToken();
  }

  // 토큰을 모두 삭제하는 메소드
  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {  // 통신 성공 (response == 200)
      final resp = await dio.post('http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          },
        ),
      );

      // refreshToken이 만료된 accessToken을 새롭게 갱신
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => RootTab(),  // RootTab으로 이동
          ),
              (route) => false
      );

    } catch(e) {  // 통신 에러
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen(),  // LoginScreen으로 이동
          ),
              (route) => false  // true : 이전의 페이지들을 유지
        // false : 이전의 페이지들을 제거
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width /2,
              ),
              const SizedBox(height: 16.0),
              const CircularProgressIndicator(  // 로딩 중 표시
                color: Colors.white,
              ),
            ],
          ),
        )
    );
  }
}
