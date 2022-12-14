// ignore_for_file: unused_local_variable

//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matcher/matcher.dart';

import '../../util/constants/color_constants.dart';
import '../../util/constants/dismension_constant.dart';



class UploadPostPage extends StatefulWidget {
  const UploadPostPage({Key? key, required this.symbol}) : super(key: key);

  final String symbol;

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {


  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;


    final imageTemporary = File(image.path);

    setState(() {
      print("tới hàm set state\n");
      print(_image);
      this._image = imageTemporary;
    });
  }

  static const double sizeOfWord = 18;
  static const double sizeOfUsername = 20;
  static const double sizeOfHeading = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        title: Text(
          "Create Your New Post", 
          style: TextStyle(color: Colors.white, fontSize: sizeOfHeading ),
        ),
        actions: [
          TextButton(
                    onPressed: () {}, 
                    child: Text("POST", style: TextStyle(fontSize: sizeOfUsername, color: Colors.white),),
                  ),
        ],
        
       //backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height*0.15,
            //   child: Row(
            //     //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     //crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text("logo", style: TextStyle(fontSize: sizeOfUsername),),
            //       Spacer(),
            //       TextButton(
            //         onPressed: () {}, 
            //         child: Text("POST", style: TextStyle(fontSize: sizeOfUsername, color: Colors.blue.shade200),),
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(height: 10,),
            // profile + user name
            // username
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                ProfilePicture(
                    name: 'Fall Angel',
                    radius: 20,
                    fontsize: sizeOfUsername,
                    //count: 3,
                    //random: true,
                    tooltip: true,
                ),
                SizedBox(width: 10,),
                Text("Fall Angel", style: TextStyle(fontSize: sizeOfUsername, fontWeight: FontWeight.bold),),

              ],
            ),

            //  space
            SizedBox(height: 20,), 

            // Content
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: TextField(
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: "Enter your content",
                    hintStyle: TextStyle(fontSize: sizeOfWord),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                  style: TextStyle(fontSize: sizeOfWord, color: ColorPalette.text1Color,)
                ),
            ),

            // space
            SizedBox(height: 20,),
            
            // button
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: ElevatedButton(
                onPressed: () => getImage(),
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Icon(Icons.image),
                    SizedBox(width: 5,),
                    Text('Upload your image'),

                  ],
                  
                ),
              ),
            ),

            //space
            SizedBox(height: 15,),


            _image != null ? Image.file(_image!, height: MediaQuery.of(context).size.height*0.25, fit: BoxFit.cover,) :Image.network(
              "https://i.pinimg.com/236x/a5/a6/2f/a5a62f9e42e6ec8fb6727811151d2b71.jpg",
              width: MediaQuery.of(context).size.width*0.6,  
            )
          ],
        ),

      ),
    );
  }
}