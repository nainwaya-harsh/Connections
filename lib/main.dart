import 'dart:developer';

import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/features/authentication/services/auth_service.dart';
import 'package:connections/features/home/screens/home_screen.dart';
import 'package:connections/features/splash_screeen/splash_screen.dart';
import 'package:connections/provider/event_provider.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:connections/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context)=>EventProvider())
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application
  final AuthService _auth = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: ((settings) => generateRoute(settings)),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Provider.of<UserProvider>(context).user.fname.isEmpty
      //     ? const SplashScreen()
      //     : BottomNavigation(),
      home: SplashScreen(),
    );
  }
}

