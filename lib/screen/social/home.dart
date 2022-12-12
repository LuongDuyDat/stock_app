import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stock_app/component/comment.dart';
import 'package:stock_app/component/post.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/util/constants/color_constants.dart';
import 'package:stock_app/util/constants/dismension_constant.dart';

import 'upload_post.dart';

class HomeBlogPage extends StatefulWidget {
  const HomeBlogPage({super.key});

  @override
  State<HomeBlogPage> createState() => _HomeBlogPageState();
}

class _HomeBlogPageState extends State<HomeBlogPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Trang chủ", style: TextStyle(color: ColorPalette.text1Color),), backgroundColor: Colors.white,),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Row(children: [
              Expanded (
                flex: 1,
                child: GestureDetector(
                  child: ProfilePicture(
                    name: 'Fall Angel',
                    radius: 20,
                    fontsize: 18,
                    //count: 3,
                    //random: true,
                    tooltip: true,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: TextField(
                  onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return PostPage();
                          })
                          );
                      },
                  decoration: InputDecoration(
                    hintText: "Write your new story...",
                    // prefixIcon: Padding(
                    //   padding: EdgeInsets.all(kTopPadding),
                    //   child: Icon(
                    //     FontAwesomeIcons.magnifyingGlass,
                    //     color: ColorPalette.text1Color,
                    //     size: 2*kTopPadding,
                    //   ),
                    // ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                    ),
                  ),
                  style: TextStyle(fontSize: 14, color: ColorPalette.text1Color,),
                  readOnly: true,
                ),
              ),
              Expanded(flex: 1, child: Icon(FontAwesomeIcons.penToSquare),)
            ]),
          ),
          // test post
          GestureDetector(
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return PostPage();
                    })
                    );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: PostItem(
                name: 'Fall Angel',
                time: "1d ago",
                description: "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
                image: "https://i.pinimg.com/236x/72/56/64/72566455ccfe235e8279a89ad7fb8b01.jpg",
                like: 1000,
                comment: 3,
              ),
            ),
          ),
          Comment(
            name: 'Luong Dat',
            time: '5m',
            content: 'Chao cau! Toi La Dat',),
        ]
      ),
    );
  }
}