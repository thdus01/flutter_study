import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {

  final Color? backgroundColor;
  final Widget child;
  final String? title;   // appbar 안의 title
  final Widget? bottomNavigationBar;   // 하단 navigationbar 위젯

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,  // null일 때 white 색
      appBar: renderAppbar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppbar() {
    if(title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
