import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/post_hive_repository.dart';
import 'package:stock_app/util/globals.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    Key? key,
    required this.id,
    required this.name,
    required this.time,
    required this.description,
    required this.image,
    required this.like,
    required this.comment,
  }) : super(key: key);

  final dynamic id;
  final String name;
  final String time;
  final String description;
  final Uint8List image;
  final int like;
  final int comment;

  @override
  State<StatefulWidget> createState() => _PostItemState();

}

class _PostItemState extends State<PostItem> {

  late PostHiveRepository postHiveRepository;
  late int like;
  late bool isFavorite;

  @override
  void initState() {
    Box<PostHive> p = Hive.box<PostHive>('post');
    postHiveRepository = PostHiveRepository(postBox: p);
    PostHive? post = p.get(widget.id);
    if (post == null) {
      isFavorite = false;
    }
    isFavorite = post!.like.contains(account);
    like = widget.like;
    super.initState();
  }

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
                name: widget.name,
                radius: 16,
                fontsize: 16,
                //count: 3,
                //random: true,
                tooltip: true,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  Text(widget.time, style: TextStyle(fontSize: 12,),),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),// space
          // Description
          Text(
            widget.description,
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
                child: Image.memory(widget.image, fit: BoxFit.cover,),
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
                          icon: isFavorite ? Icon(FontAwesomeIcons.heart, color: Colors.red,) : Icon(FontAwesomeIcons.heart,),
                          onPressed: () async{
                            if (isFavorite) {
                              bool success = await postHiveRepository.deleteFavorite(account.key, widget.id);
                              if (success) {
                                setState(() {
                                  isFavorite = false;
                                  like--;
                                });
                              }
                            } else {
                              bool success = await postHiveRepository.addFavorite(account.key, widget.id);
                              if (success) {
                                setState(() {
                                  isFavorite = true;
                                  like++;
                                });
                              }
                            }
                          },
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
                        Text(widget.comment.toString(),),
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