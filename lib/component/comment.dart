import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:stock_app/util/globals.dart';

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
    required this.name,
    required this.time,
    required this.content,
  });

  final String name;
  final String time;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          ProfilePicture(
            name: name,
            radius: 16,
            fontsize: 18,
          ),
          SizedBox(width: screenWidth * 0.02,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0.03 * screenWidth, vertical: 0.005 * screenHeight,),
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
              color: Color.fromRGBO(241, 241, 241, 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005,),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}