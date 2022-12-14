import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_app/util/globals.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.name,
    required this.time,
    required this.description,
    required this.image,
    required this.like,
    required this.comment,
  }) : super(key: key);

  final String name;
  final String time;
  final String description;
  final Uint8List image;
  final int like;
  final int comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenHeight * 0.012),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // username
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfilePicture(
                name: name,
                radius: 16,
                fontsize: 18,
                //count: 3,
                //random: true,
                tooltip: true,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  Text(time, style: TextStyle(fontSize: 12,),),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),// space
          // Description
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.start,
          ),
          // image
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.25,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade50, width: 1.5)),
                child: Image.memory(image, fit: BoxFit.cover,),
              ),
            ],
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
                        Text(like.toString(),),
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
                        Text(comment.toString(),),
                      ],
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}