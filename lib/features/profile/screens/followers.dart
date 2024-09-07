import 'package:connections/common/widgets/common_button.dart';
import 'package:connections/features/GuestAccount/screens/guest_profile.dart';
import 'package:connections/features/profile/services/followers.dart';
import 'package:connections/models/userModel.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Followers extends StatefulWidget {
  static const routeName='/followers';
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  List<User>? followersUsers=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFollowersData();
  }
   void _loadFollowersData() async {
    FollowersData followingData = FollowersData();
    await followingData.getFollowersData(context);
    setState(() {
      followersUsers = followingData.followersUsers;
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
        itemCount: followersUsers!.length,
        itemBuilder: (context, index) {
          User user = followersUsers![index];
          return ListTile(
            leading: CircleAvatar(),
            title: Text('${user.fname} ${user.lname}'),
            subtitle: Text(user.email),
            trailing: Container(height:30,width: 130,
              child: customButton(title: 'Follow', ontap: (){
                                Navigator.pushNamed(context, GuestProfile.routeName,arguments: followersUsers?[index]);
                              }),
            )

          );
        },
      ),
    );
  }
}