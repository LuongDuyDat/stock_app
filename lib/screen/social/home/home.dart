import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/util/constants/color_constants.dart';
import 'package:stock_app/util/constants/dismension_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ColorPalette.backgroundScaffoldColor,
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Trang chủ", style: TextStyle(color: ColorPalette.text1Color),), backgroundColor: Colors.white,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            // search tab
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kTopPadding), 
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: ColorPalette.text1Color,
                    size: 2*kTopPadding,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(kItemPadding,)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: TextStyle(fontSize: 14, color: ColorPalette.text1Color,)
            ),
          ),
          

          // test post
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade100, style: BorderStyle.solid, width: 2,), 
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  // username
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfilePicture(
                          name: 'Fall Angel',
                          radius: 20,
                          fontsize: 18,
                          //count: 3,
                          random: true,
                          tooltip: true,
                      ),
                      SizedBox(width: 10,),
                      Text("Fall Angel", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  // Description
                  Text(
                    "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
                    style: TextStyle(
                      
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          )
        ]
      ),
      
    );
  }
}