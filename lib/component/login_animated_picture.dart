import 'package:flutter/cupertino.dart';

class LoginPicture extends StatelessWidget {
  const LoginPicture({
    Key? key,
    required this.activeIndex,
    required this.index,
    required this.pictureUrl
  }) : super(key: key);

  final int activeIndex;
  final int index;
  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedOpacity(
        opacity: activeIndex == index ? 1 : 0,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
        child: Image.network(pictureUrl, height: 400,),
      ),
    );
  }

}