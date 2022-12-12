import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../util/constants/color_constants.dart';
import '../../util/constants/dismension_constant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Search'),
      ),
      body: Column(
        children: [
          //sizebox
          SizedBox(height: 5,),
          
          // search tab
          TextField(
                  
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
                  //readOnly: true,
                ),
        ],
      ),
    );
  }
}