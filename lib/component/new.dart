
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:stock_app/util/globals.dart';

class NewItem extends StatelessWidget {
  const NewItem({
    Key? key,
    required this.name,
    this.time,
    this.image,
    required this.description,
  }) : super(key: key);

  final String name;
  final String? time;
  final String? image;
  final String description;
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
                fontsize: 16,
                //count: 3,
                //random: true,
                tooltip: true,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  Text(time != null ? time! : '', style: TextStyle(fontSize: 12,),),
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
          image != null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.25,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade50, width: 1.5)),
                child: Image.network(image!, fit: BoxFit.cover,),
              ),
            ],
          ) : const Center(),
          SizedBox(height: 10,), // space
          // likes and comment
        ],
      ),
    );
  }

}