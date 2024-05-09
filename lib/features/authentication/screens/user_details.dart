import 'package:connections/common/widgets/textform.dart';
import 'package:connections/constants/colors.dart';
import 'package:connections/features/authentication/screens/signup.dart';
import 'package:connections/features/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  static const String routeName = '/user-details';
  final String mobileNumber;
  const UserDetails({super.key, required this.mobileNumber});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final signInFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  void signUp() {
    authService.signupUser(
        context,
        _fnameController.text.toString(),
        _lnameController.text.toString(),
        _emailController.text.toString(),
        _numberController.text.toString(),
        _passwordController.text.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key: signInFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.0007,
              ),
              InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, SignUpNumber.routeName);
                },
                child: Image.asset(
                  'assets/icons/back_arrow.png',
                  scale: 3.5,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Get Started',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
              ),
              SizedBox(
                height: height * 0.007,
              ),
              Text(
                'Turn events into lasting friendships!',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Profile Picture',
                style: TextStyle(
                    color: Color(0xfffA294A8),
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              Container(
                width: 100,
                child: Stack(
                  children: [
                    CircleAvatar(
                        minRadius: 60,
                        backgroundColor: Color(0xfffEBE9EC),
                        child: Image.asset(
                          'assets/icons/profile.png',
                          color: Color(0xfffA294A8),
                          height: 60,
                        )),
                    Positioned(
                      bottom: 8,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Color(0xfffDDD8DF), // Adjust color as needed
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black, // Adjust icon color as needed
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.007,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _fnameController,
                      decoration: InputDecoration(
                          hintText: 'First Name*',
                          fillColor: Color(0xfffF5F4F6),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: backgroundColor),
                              borderRadius: BorderRadius.circular(16)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffBD57EA)),
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _lnameController,
                      decoration: InputDecoration(
                          hintText: 'Last Name*',
                          fillColor: Color(0xfffF5F4F6),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: backgroundColor),
                              borderRadius: BorderRadius.circular(16)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfffBD57EA)),
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: 'Email*',
                    fillColor: Color(0xfffF5F4F6),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: backgroundColor),
                        borderRadius: BorderRadius.circular(16)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfffBD57EA)),
                        borderRadius: BorderRadius.circular(16))),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _numberController,
                // initialValue: widget.mobileNumber,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    hintText: 'Mobile Number*',
                    fillColor: Color(0xfffF5F4F6),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: backgroundColor),
                        borderRadius: BorderRadius.circular(16)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfffBD57EA)),
                        borderRadius: BorderRadius.circular(16))),
              ),
              SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                  controller: _passwordController, title: 'Password'),
              // Obx(() {
              //   return Container(
              //     decoration: BoxDecoration(
              //       color: Color(0xfffF5F4F6),
              //       borderRadius: BorderRadius.circular(16.0),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8),
              //       child: DropdownButton2<String>(
              //         alignment: Alignment.center,
              //         buttonStyleData: ButtonStyleData(
              //           width: double
              //               .infinity, // Set button width to match container width
              //           // borderRadius: BorderRadius.circular(16.0), // Set button border radius
              //         ),
              //         value: _controller.selectedGender.value,
              //         // icon: Icon(Icons.arrow_drop_down),
              //         // iconSize: 24,
              //         // elevation: 16,
              //         underline: Container(
              //           height: 0,
              //           color: Colors.transparent,
              //         ),
              //         onChanged: (newValue) {
              //           _controller.selectedGender.value = newValue!;
              //         },
              //         items: [
              //           DropdownMenuItem<String>(
              //             value: 'Male',
              //             child: Text(
              //               'Male',
              //             ),
              //           ),
              //           DropdownMenuItem<String>(
              //             value: 'Female',
              //             child: Text('Female'),
              //           ),
              //         ],
              //       ),
              //     ),
              //   );
              // }),
              SizedBox(
                height: 12,
              ),
              // TextFormField(
              //   maxLines: 4,
              //   decoration: InputDecoration(
              //       hintText: 'Enter Your Bio',
              //       counter: Text(''),
              //       fillColor: Color(0xfffF5F4F6),
              //       filled: true,
              //       enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(color: backgroundColor),
              //           borderRadius: BorderRadius.circular(16)),
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(color: Color(0xfffBD57EA)),
              //           borderRadius: BorderRadius.circular(16))),
              // ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      minimumSize: Size(358, 62),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    // Get.to(OTPScreen(
                    //   verificationId: '', typeofAuth: 'signup',
                    // ));
                    // Get.off(HomepageView());
                    signUp();
                    print(_fnameController.text);
                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an account? ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
