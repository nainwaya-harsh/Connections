import 'package:connections/features/home/widgets/friends_checkins.dart';
import 'package:connections/features/home/widgets/popular_checkins.dart';
import 'package:connections/features/home/widgets/storyrow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      // drawer: MyDrawer(),
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
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/search.png',
                height: 45,
              )),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/notification.png',
                height: 45,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
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
                      //   StoryRow(true, '', 'Your Status', true),
                      //   StoryRow(false, '', 'Tushar', false),
                      //   StoryRow(false, '', 'Tushar', false),
                      //   StoryRow(false, '', 'Tushar', false),
                      //   StoryRow(false, '', 'Tushar', false),
                      // StoryRow(false, '', 'Tushar', false),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [PopularCheckins(), PopularCheckins()],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      'Friends Check-ins',
                      style: GoogleFonts.nunito(
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                  FriendsCheckins(),
                  FriendsCheckins(),
                  FriendsCheckins(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
