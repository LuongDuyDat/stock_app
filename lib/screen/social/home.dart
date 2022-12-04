import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/util/constants/color_constants.dart';
import 'package:stock_app/util/constants/dismension_constant.dart';

import 'post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor.withOpacity(0.1),
      //backgroundColor: Colors.white,
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
                      borderSide: BorderSide(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                    ),
                    focusedBorder:  OutlineInputBorder(
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
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100, style: BorderStyle.solid, width: 2,), 
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
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
                            radius: 16,
                            fontsize: 18,
                            //count: 3,
                            //random: true,
                            tooltip: true,
                        ),
                        SizedBox(width: 10,),
                        Text("Fall Angel", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                      ],
                    ),
          
                    SizedBox(height: 10,),// space
          
                    // Description
                    Text(
                      "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
                      style: TextStyle(
                
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
          
                    //SizedBox(height: 10,),// space
          
                    // image
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.25,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade50, width: 1.5)),
                          child: Expanded (child: Image.network("https://i.pinimg.com/236x/72/56/64/72566455ccfe235e8279a89ad7fb8b01.jpg")),
                        ),
                      ],
                    ),
          
                    // title
                    Container(
                      child: Text(
                        "Dự đoán chứng khoán Dự đoán chứng khoán Dự đoán chứng khoán Dự đoán chứng khoán Dự đoán chứng khoán Dự đoán chứng khoán",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
          
                    SizedBox(height: 10,), // space
          
                    // likes and comment
                    Container(
                      child: Row(
                        children: [
          
                          // like
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.heart),
                                  onPressed: () {},
                                ),
                                
                                Text(
                                  "1000"
                                )
                              ],
                            )
                          ),
          
                          // comment
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.comment),
                                  onPressed: () {},
                                ),
                                
                                Text(
                                  "3"
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    )
          
                  ],
                ),
              ),
            ),
          )
        ]
      ),
      
    );
  }
}