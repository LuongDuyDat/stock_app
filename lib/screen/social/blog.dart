import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:stock_app/screen/social/home.dart';
import 'package:stock_app/screen/social/upload_post.dart';
import 'package:stock_app/screen/social/profile.dart';
import 'package:stock_app/screen/social/search.dart';
import 'package:stock_app/util/constants/color_constants.dart';
import 'package:stock_app/util/constants/dismension_constant.dart';

import '../../util/globals.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeBlogPage(),
          SearchPage(),
          ProfilePage(),
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
          // search
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass, size: kDefaultIconSize,), 
            title: Text("Search"),
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