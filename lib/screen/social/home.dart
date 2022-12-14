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
import 'package:stock_app/util/globals.dart';

import '../../util/string.dart';
import 'upload_post.dart';

class HomeBlogPage extends StatefulWidget {
  const HomeBlogPage({super.key, required this.symbol});

  final String symbol;

  @override
  State<HomeBlogPage> createState() => _HomeBlogPageState();
}

class _HomeBlogPageState extends State<HomeBlogPage> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 0.02 * screenWidth, height: screenHeight * 0.05, color: Colors.grey.shade300,),
                Container(
                  width: 0.96 * screenWidth,
                  height: screenHeight * 0.05,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(108, 217, 134, 1.0),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5, top: 5),
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: Colors.black, size: 20,),
                      hintText: searchString,
                      enabledBorder: OutlineInputBorder(
                        //borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color.fromRGBO(108, 217, 134, 1.0), width: 1),
                      ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    autofocus: false,
                    cursorColor: Color.fromRGBO(108, 217, 134, 1.0),
                    onChanged: (text) {
                      //context.read<HomeBloc>().add(HomeSearchSymbol(searchContent: text));
                    },
                  ),
                ),
                Container(width: 0.02 * screenWidth, height: screenHeight * 0.05, color: Colors.grey.shade300,),
              ],
            ),
            Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
            // test post
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UploadPostPage(symbol: widget.symbol);
                    })
                );
              },
              child: PostItem(
                name: 'Fall Angel',
                time: "1d ago",
                description: "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
                image: "https://i.pinimg.com/236x/72/56/64/72566455ccfe235e8279a89ad7fb8b01.jpg",
                like: 1000,
                comment: 3,
              ),
            ),
            Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return UploadPostPage(symbol: widget.symbol);
                    })
                );
              },
              child: PostItem(
                name: 'Fall Angel',
                time: "1d ago",
                description: "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
                image: "https://i.pinimg.com/236x/72/56/64/72566455ccfe235e8279a89ad7fb8b01.jpg",
                like: 1000,
                comment: 3,
              ),
            ),
            // Comment(
            //   name: 'Luong Dat',
            //   time: '5m',
            //   content: 'Chao cau! Toi La Dat',),
          ]
      ),
    );
  }
}