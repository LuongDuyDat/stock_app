import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/post_hive_repository.dart';
import 'package:stock_app/screen/social/home/social_home_view/blog.dart';
import 'package:stock_app/screen/social/home/social_home_view/home.dart';
import 'package:stock_app/screen/social/upload_post/bloc/upload_post_bloc.dart';
import 'package:stock_app/screen/social/upload_post/bloc/upload_post_event.dart';
import 'package:stock_app/screen/social/upload_post/bloc/upload_post_state.dart';
import 'package:stock_app/util/globals.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

import '../../../../util/constants/color_constants.dart';


class UploadPostPage extends StatelessWidget {
  const UploadPostPage({Key? key, required this.symbol}) : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) {
    Box<PostHive> postBox = Hive.box<PostHive>('post');
    return BlocProvider(
      create: (_) => UploadPostBloc(postHiveRepository: PostHiveRepository(postBox: postBox)),
      child: UploadPostView(symbol: symbol),
    );
  }


}

class UploadPostView extends StatefulWidget {
  const UploadPostView({Key? key, required this.symbol}) : super(key: key);

  final String symbol;

  @override
  State<UploadPostView> createState() => _UploadPostViewState();
}

class _UploadPostViewState extends State<UploadPostView> {

  static const double sizeOfWord = 18;
  static const double sizeOfUsername = 20;
  static const double sizeOfHeading = 20;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostBloc, UploadPostState>(
      builder: (context, state) {
        switch (state.uploadPostStatus) {
          case UploadPostStatus.success:
            return FutureBuilder<Future>(
              builder: (context, snapshot) {
                return const Center();
              },
              future: Future.microtask(() {
                Navigate.popPage(context);
                return Navigate.pushPageReplacement(context, BlogPage(symbol: widget.symbol,));
              }),
            );
          default:
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black,),
                  onPressed: () {
                    Navigate.popPage(context);
                  },
                ),
                leadingWidth: screenWidth * 0.15,
                backgroundColor: Colors.white,
                title: Text(
                  createPostString,
                  style: TextStyle(color: ColorPalette.text1Color, fontSize: sizeOfHeading ),
                ),
                centerTitle: true,
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<UploadPostBloc>().add(UploadPostSubmit(symbol: widget.symbol));
                    },
                    //icon: Icon(Icons.cloud_upload_outlined, color: Colors.black,),
                    child: Text(postString, style: TextStyle(fontSize: sizeOfWord, color: Color.fromRGBO(108, 217, 134, 1.0), fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(width: screenWidth * 0.015,),
                ],

                //backgroundColor: Colors.white,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.03,),
                    // profile + user name
                    // username
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: screenWidth * 0.04,),
                        ProfilePicture(
                          name: account.name,
                          radius: 20,
                          fontsize: sizeOfUsername,
                          //count: 3,
                          //random: true,
                          tooltip: true,
                        ),
                        SizedBox(width: screenWidth * 0.02,),
                        Text(account.name, style: TextStyle(fontSize: sizeOfUsername, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    //  space
                    SizedBox(height: screenHeight * 0.03,),
                    // Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.015 * screenWidth),
                      child: TextField(
                        maxLines: 8,
                        cursorColor: Color.fromRGBO(108, 217, 134, 1.0),
                        decoration: InputDecoration(
                          hintText: enterContent,
                          hintStyle: TextStyle(fontSize: sizeOfWord),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.05 * screenWidth, vertical: 0.025 * screenHeight),
                          //border: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        style: TextStyle(fontSize: sizeOfWord, color: ColorPalette.text1Color,),
                        onChanged: (value) {
                          context.read<UploadPostBloc>().add(UploadPostContentChange(content: value));
                        },
                      ),
                    ),
                    // space
                    SizedBox(height: 0.025 * screenHeight,),
                    // button
                    InkWell(
                      onTap: () async{
                        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                        print(image);
                        if (image != null) {
                          context.read<UploadPostBloc>().add(UploadPostImageChange(file: image));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        width: screenWidth * 0.5,
                        color: Color.fromRGBO(108, 217, 134, 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 0.012 * screenWidth,),
                            Icon(Icons.image, color: Colors.white,),
                            SizedBox(width: 0.012 * screenWidth,),
                            Text(uploadImage, style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                    //space
                    SizedBox(height: screenHeight * 0.03,),
                    state.pickedImage != null ? Image.file(File(state.pickedImage!.path), height: screenHeight * 0.38, fit: BoxFit.cover,) :Image.network(
                      "https://i.pinimg.com/236x/a5/a6/2f/a5a62f9e42e6ec8fb6727811151d2b71.jpg",
                      height: screenHeight * 0.38, fit: BoxFit.cover,
                    )
                  ],
                ),

              ),
            );
        }
      },
    );
  }
}