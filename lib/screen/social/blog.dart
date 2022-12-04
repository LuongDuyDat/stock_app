import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stock_app/screen/social/home.dart';
import 'package:stock_app/screen/social/post.dart';
import 'package:stock_app/screen/social/search.dart';
import 'package:stock_app/util/constants/color_constants.dart';
import 'package:stock_app/util/constants/dismension_constant.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          SearchPage(),
          //Container(color: Colors.blue,),
          Container(color: Colors.pink,),
          Container(color: Colors.purple,),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.2),
        margin: EdgeInsets.symmetric(horizontal: kMediumPadding, vertical: kDefaultPadding),
        items: [
          // home
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.house, size: kDefaultIconSize,), 
            title: Text("Home"),
          ),
          // post
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.locationArrow, size: kDefaultIconSize,), 
            title: Text("Post"),
          ),
          // likes
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.solidHeart, size: kDefaultIconSize,), 
            title: Text("Likes"),
          ),
          // profile
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.solidUser, size: kDefaultIconSize,), 
            title: Text("Profile"),
          ),
        ]
        ),
    );
  }
}