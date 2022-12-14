import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_app/screen/social/home/social_home_view/home.dart';
import 'package:stock_app/screen/social/home/social_home_view/new.dart';
import 'package:stock_app/screen/social/upload_post/view/upload_post.dart';
import 'package:stock_app/util/constants/color_constants.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

import '../../../../util/globals.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key, required this.symbol}) : super(key: key);

  final String symbol;

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(groupString + ' ' + widget.symbol, style: TextStyle(color: ColorPalette.text1Color),),
          backgroundColor: Colors.white,
          leading: IconButton(
             onPressed: () {
               Navigate.popPage(context);
             },
            icon: Icon(Icons.arrow_back, color: ColorPalette.text1Color,),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigate.pushPage(context, UploadPostPage(symbol: widget.symbol,));
              },
              icon: Icon(FontAwesomeIcons.penToSquare, color: ColorPalette.text1Color,),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: homeString,),
              Tab(text: newsString,),
            ],
            labelColor: Color.fromRGBO(108, 217, 134, 1.0),
            unselectedLabelColor: ColorPalette.text1Color,
            indicatorColor: Color.fromRGBO(108, 217, 134, 1.0),
            labelStyle: TextStyle(fontWeight: FontWeight.bold,),
          ),
        ),
        body: TabBarView(
          children: [
            HomeBlogPage(symbol: widget.symbol),
            BlogNewPage(symbol: widget.symbol),
          ],
        ),
      ),
    );
  }
}