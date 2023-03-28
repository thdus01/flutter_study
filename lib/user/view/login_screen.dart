import 'dart:convert';
import 'dart:io';

import 'package:deliveryapp/common/const/colors.dart';
import 'package:deliveryapp/common/const/data.dart';
import 'package:deliveryapp/common/layout/default_layout.dart';
import 'package:deliveryapp/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/component/custom_test_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    final dio = Dio();  // dio 선언

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(),
              const SizedBox(
                height: 16.0,
              ),
              _SubTitle(),
              Image.asset(
                'asset/img/misc/logo.png',
                width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              CustomTextFormField(
                hintText: '이메일을 입력해주세요.',
                onChanged: (String value) {  // 값이 바뀔 때 마다 콜백이 불림 (value는 실제 textfield에 입력한 값이 출력)
                  username = value;  // username 선언

                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextFormField(
                hintText: '비밀번호를 입력해주세요.',
                onChanged: (String value) {
                  password = value;
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    // ID:비밀번호
                    // base64로 인코딩 필요
                    final rawString = '$username:$password';

                    print(rawString);

                    // base64로 인코딩하는 과정
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post('http://$ip/auth/login',
                        options: Options(
                          headers: {
                            'authorization': 'Basic $token',
                          },
                        ),
                    );

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];


                    storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                    // 페이지 이동
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RootTab(),
                      )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text(
                      '로그인'
                  ),
              ),
              TextButton(
                  onPressed: () async {

                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text(
                    '회원가입',
                  )
              ),
            ],
    ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
        '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 14.0,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}


