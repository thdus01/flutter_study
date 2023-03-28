import 'package:deliveryapp/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.hintText,
    this.errorText,
    this.obscureText = false,  // 기본값 false
    this.autofocus = false,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField (
        cursorColor: PRIMARY_COLOR,

        // 비밀번호 입력할 때 글자 숨기기 기능
        obscureText: obscureText,
        // 자동 포커스 여부
        autofocus: autofocus,
        // 값이 바뀔 때마다 실행되는 callback
        onChanged: onChanged,

        decoration:  InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: const TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 16.9,
          ),
          fillColor: INPUT_BG_COLOR,  // input 부분 배경색
          // false - 배경색 없음
          // true - 배경색 있음
          filled: true,

          // 모든 Input 상태의 기본 스타일 세팅
          border: baseBorder,
          enabledBorder: baseBorder,  // 논클릭 상태일 땐 투명이었다가 포커스 상태일 땐 border가 생김
          // 포커스 상태의 border
          // baseBorder의 값을 유지한 상태로, borderSide의 값만 바꿔준다.
          // 위에 정의된 borderSide에서 색깔을 PRIMARY_COLOR로 바꿔줌.
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: PRIMARY_COLOR,
            ),
          ),
        ),
      );
  }
}
