import 'dart:developer';

import 'package:connections/common/widgets/common_button.dart';
import 'package:connections/features/GuestAccount/screens/guest_profile.dart';
import 'package:connections/features/profile/services/following_data.dart';
import 'package:connections/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class Following extends StatefulWidget {
  static const routeName='/following';
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
List<User>? followingUsers=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFollowingData();
  }
   void _loadFollowingData() async {
    FollowingData followingData = FollowingData();
    await followingData.getFollowingData(context);
    setState(() {
      followingUsers = followingData.followingUsers;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: Image.asset(
            'assets/icons/back_arrow.png',
            scale: 4.5,
          ),
        ),
        title: Text('Following'),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: followingUsers!.length,
        itemBuilder: (context, index) {
          User user = followingUsers![index];
          return ListTile(
            leading: CircleAvatar(),
            title: Text('${user.fname} ${user.lname}'),
            subtitle: Text(user.email),
            trailing: Container(height:30,width: 130,
              child: customButton(title: 'Follow', ontap: (){
                                Navigator.pushNamed(context, GuestProfile.routeName,arguments: followingUsers?[index]);
                              }),
            )

          );
        },
      ),
    );
  }
}