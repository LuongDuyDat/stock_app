import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:stock_app/component/button.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  static const Color buttonColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),

      body: Column(
        children: [
          // space
          SizedBox(height: 30,),

          // Profile picture
          ProfilePicture(
                            name: 'Fall Angel',
                            radius: 16,
                            fontsize: 18,
                            //count: 3,
                            //random: true,
                            tooltip: true,
                        ),

          // space
          
          

          // space
          SizedBox(height: 20,),

          // Log out
          Button(color: buttonColor, child: Text("Log out"), onPressed: () {},),
        ],
      ),
    );
  }
}