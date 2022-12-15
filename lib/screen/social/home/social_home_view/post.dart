import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/component/comment.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/util/globals.dart';

import '../../../../repositories/social_repository/post_hive_repository.dart';
import '../../../../util/constants/color_constants.dart';
import '../../../../util/navigate.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../util/string.dart';


class PostBlogPage extends StatefulWidget {
  const PostBlogPage({required this.post});

  final PostHive post;

  @override
  State<StatefulWidget> createState() => _PostBlogPageState();

}

class _PostBlogPageState extends State<PostBlogPage> {

  late PostHiveRepository postHiveRepository;
  late PostHive post;
  late int like;
  late bool isFavorite;
  late List<CommentHive> commentList;
  late String content;
  late TextEditingController controller;

  late double width;
  late double height;
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    width = screenWidth;
    height = screenHeight * 0.78;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          height = screenHeight * 0.42;
        });
      } else {
        setState(() {
          height = screenHeight * 0.78;
        });
      }
    });
    post = widget.post;
    commentList = post.comments;
    Box<PostHive> p = Hive.box<PostHive>('post');
    postHiveRepository = PostHiveRepository(postBox: p);
    isFavorite = post.like.contains(account);
    like = post.like.length;
    content = '';
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigate.popPage(context);
          },
          icon: Icon(Icons.arrow_back, color: ColorPalette.text1Color,),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePicture(
              name: post.id,
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
                Text(post.id, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorPalette.text1Color,),),
                Text(timeago.format(post.createAt, locale: 'en_short'), style: TextStyle(fontSize: 12, color: ColorPalette.text1Color,),),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.03 * screenWidth,vertical: screenHeight * 0.01),
                    child: Text(
                      post.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Image.memory(post.image!, fit: BoxFit.contain,),
                  // image
                  Padding(
                    padding: EdgeInsets.only(left: 0.01 * screenWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: isFavorite ? Icon(FontAwesomeIcons.heart, color: Colors.red,) : Icon(FontAwesomeIcons.heart,),
                          onPressed: () async{
                            if (isFavorite) {
                              bool success = await postHiveRepository.deleteFavorite(account.key, post.key);
                              print(success);
                              if (success) {
                                setState(() {
                                  isFavorite = false;
                                  like--;
                                });
                              }
                            } else {
                              bool success = await postHiveRepository.addFavorite(account.key, post.key);
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
                    ),
                  ),
                  Divider(thickness: 1,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Comment(
                        createAt: commentList.reversed.elementAt(index).createAt,
                        name: commentList.reversed.elementAt(index).userName,
                        time: timeago.format(commentList.reversed.elementAt(index).createAt, locale: 'en_short'),
                        content: commentList.reversed.elementAt(index).content,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 0.01 * screenHeight,);
                    },
                    itemCount: commentList.reversed.length,
                  ),
                ],
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.only( left: 0.04 * screenWidth, right: 0.04 * screenWidth),
            height: screenHeight * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfilePicture(
                  name: post.id,
                  radius: 18,
                  fontsize: 18,
                  //count: 3,
                  //random: true,
                  tooltip: true,
                ),
                Container(
                  width: 0.67 * screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(108, 217, 134, 1.0),
                    ),
                    onChanged: (text) {
                      setState(() {
                        content = text;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: screenWidth * 0.03,),
                      hintText: writeComment,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    autofocus: false,
                    cursorColor: Color.fromRGBO(108, 217, 134, 1.0),
                    focusNode: _focusNode,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    CommentHive? success = await postHiveRepository.addComment(account.name, post.key, content);
                    if (success != null) {
                      setState(() {
                        controller.text = '';
                      });
                    }
                  },
                  icon: Icon(Icons.send, color: Color.fromRGBO(108, 217, 134, 1.0),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}