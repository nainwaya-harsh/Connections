import 'package:connections/constants/colors.dart';
import 'package:connections/features/createEvent/screens/attend_event.dart';
import 'package:connections/features/createEvent/services/event.dart';
import 'package:connections/features/home/widgets/friends_checkins.dart';
import 'package:connections/features/home/widgets/popular_checkins.dart';
import 'package:connections/features/home/widgets/storyrow.dart';
import 'package:connections/features/notification/screens/notification.dart';
import 'package:connections/features/profile/services/following_data.dart';
import 'package:connections/features/search/screens/search_screen.dart';
import 'package:connections/models/eventModel.dart';
import 'package:connections/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  EventService _event = EventService();
  List<EventModel>? eventList;
  List<User>? friendList;
  List<Map<User, EventModel>>? newlist=[]; // Ensure this is initialized

  @override
  void initState() {
    super.initState();
    getEvents();
    _loadFriendsData();
  }

  void _loadFriendsCheckins() {
    if (friendList == null || eventList == null) return; // Check for null

    // newlist.clear(); // Clear previous data
    for (int i = 0; i < friendList!.length; i++) {
      User currentUser = friendList![i];

      for (String eventIdUser in currentUser.eventattended) {
        for (int j = 0; j < eventList!.length; j++) {
          if (eventIdUser == eventList![j].id) {
            // Add the user and the matched event to newlist
            newlist?.add({currentUser: eventList![j]});
          }
        }
      }
    }
    setState(() {}); // Trigger a rebuild
  }

  void _loadFriendsData() async {
    FollowingData friends = FollowingData();
    await friends.getFollowingData(context);
    setState(() {
      friendList = friends.followingUsers;
      _loadFriendsCheckins(); // Recalculate check-ins after loading friends
    });
  }

  void getEvents() async {
    eventList = await _event.getEvents(context);
    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 10,
        title: Image.asset(
          'assets/icons/logo.png',
          height: 40,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              icon: Image.asset(
                'assets/icons/search.png',
                height: 45,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              },
              icon: Image.asset(
                'assets/icons/notification.png',
                height: 45,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: eventList == null
          ? Center(
              child: CircularProgressIndicator(
              color: buttonColor,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StoryRow(
                                isYours: true,
                                imgUrl: '',
                                title: 'Your Status',
                                viewed: true),
                            StoryRow(
                                isYours: false,
                                imgUrl: '',
                                title: 'Harsh',
                                viewed: false),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: Color(0xfffEBE9EC),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            'Nearby Check-ins',
                            style: GoogleFonts.nunito(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: eventList!.length,
                              itemBuilder: (context, index) {
                                EventModel event = eventList![index];
                                return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, EventAttendees.routeName,
                                          arguments: event);
                                    },
                                    child: PopularCheckins(
                                      eventName: event.ename,
                                      attendees:
                                          event.eguests.length.toString(),
                                    ));
                              }),
                        ),
                        newlist!.length>0?Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            'Friends Check-ins',
                            style: GoogleFonts.nunito(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                        ):Container(),
                       if(newlist!.length>0) newlist!.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(
                                color: buttonColor,
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: newlist!.length,
                                itemBuilder: (context, index) {
                                  final entry = newlist![index];
                                  final user = entry.keys.first;
                                  final event = entry.values.first;
                                  return FriendsCheckins(
                                    name: user.fname,
                                    place: event.ecity, // Adjust based on EventModel
                                    attendees: event.eguests.length.toString(), // Adjust based on EventModel
                                    eventModel: event,
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}






// import 'package:connections/constants/colors.dart';
// import 'package:connections/features/createEvent/screens/attend_event.dart';
// import 'package:connections/features/createEvent/services/event.dart';
// import 'package:connections/features/home/widgets/friends_checkins.dart';
// import 'package:connections/features/home/widgets/popular_checkins.dart';
// import 'package:connections/features/home/widgets/storyrow.dart';
// import 'package:connections/features/profile/services/following_data.dart';
// import 'package:connections/features/search/screens/search_screen.dart';
// import 'package:connections/models/eventModel.dart';
// import 'package:connections/models/userModel.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routeName = '/home-screen';
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   EventService _event = EventService();
//   List<EventModel>? eventList;
//   List<User>? friendList;
//   List<Map<User, EventModel>> newlist=[];
//   //
//   @override
//   void initState() {
//     // TODO: implement initState
//     //  await _event.getEvents(context);
//     getEvents();
//     _loadFriendsData();
//     _loadFriendsCheckins();
//   }

//   void _loadFriendsCheckins() {
//      if (friendList == null || eventList == null) return;
//     // Iterate through each user in the friendList
//     for (int i = 0; i < friendList!.length; i++) {
//       User currentUser = friendList![i];

//       // Iterate through all the events attended by the current user
//       for (String eventIdUser in currentUser.eventattended) {
//         // Iterate through the list of all events to find a match
//         for (int j = 0; j < eventList!.length; j++) {
//           if (eventIdUser == eventList![j].id) {
//             // Add the user and the matched event to the newlist
//             newlist?.add({currentUser: eventList![j]});
//           }
//         }
//       }
//     }
//   }

//   void _loadFriendsData() async {
//     FollowingData friends = FollowingData();
//     await friends.getFollowingData(context);
//     setState(() {
//       friendList = friends.followingUsers;
//     });
//   }

//   void getEvents() async {
//     eventList = await _event.getEvents(context);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;

//     return Scaffold(
//       // drawer: MyDrawer(),
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         toolbarHeight: 70,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         titleSpacing: 10,
//         title: Image.asset(
//           'assets/icons/logo.png',
//           height: 40,
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, SearchScreen.routeName);
//               },
//               icon: Image.asset(
//                 'assets/icons/search.png',
//                 height: 45,
//               )),
//           IconButton(
//               onPressed: () {},
//               icon: Image.asset(
//                 'assets/icons/notification.png',
//                 height: 45,
//               )),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: eventList == null
//           ? Center(
//               child: CircularProgressIndicator(
//               color: buttonColor,
//             ))
//           : SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 15, top: 5),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             StoryRow(
//                                 isYours: true,
//                                 imgUrl: '',
//                                 title: 'Your Status',
//                                 viewed: true),
//                             StoryRow(
//                                 isYours: false,
//                                 imgUrl: '',
//                                 title: 'Harsh',
//                                 viewed: false),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height: 1.5,
//                     color: Color(0xfffEBE9EC),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, top: 8),
//                           child: Text(
//                             'Nearby Check-ins',
//                             style: GoogleFonts.nunito(
//                                 fontSize: 20, fontWeight: FontWeight.w800),
//                           ),
//                         ),
//                         Container(
//                           height: 100,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: eventList!.length,
//                               itemBuilder: (context, index) {
//                                 EventModel event = eventList![index];
//                                 return InkWell(
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                           context, EventAttendees.routeName,
//                                           arguments: event);
//                                     },
//                                     child: PopularCheckins(
//                                       eventName: event.ename,
//                                       attendees:
//                                           event.eguests.length.toString(),
//                                     ));
//                               }),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, top: 8),
//                           child: Text(
//                             'Friends Check-ins',
//                             style: GoogleFonts.nunito(
//                                 fontSize: 20, fontWeight: FontWeight.w800),
//                           ),
//                         ),
//                         //  friendList==null?Center(child: CircularProgressIndicator(color: buttonColor,)): ListView.builder(shrinkWrap: true,itemCount: friendList?.length,itemBuilder: (context,index){
//                         //       return FriendsCheckins(name: friendList![index].fname,place: friendList![index].lname,attendees: "5",);
//                         //   }),
//                         newlist == null
//                             ? Center(
//                                 child: CircularProgressIndicator(
//                                 color: buttonColor,
//                               ))
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: newlist?.length,
//                                 itemBuilder: (context, index) {
//                                   final entry = newlist![index];
//                                   final user = entry.keys.first;
//                                   final event = entry.values.first;
//                                   return FriendsCheckins(
//                                     name: user.fname,
//                                     place: user.lname,
//                                     attendees: "5",
//                                   );
//                                 }),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }



