import 'package:connections/common/widgets/common_button.dart';
import 'package:connections/common/widgets/textform.dart';
import 'package:connections/constants/colors.dart';
import 'package:connections/features/profile/services/profile_data.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<CustomBottomSheet> {

    TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController linkedin=TextEditingController();
  TextEditingController whatsapp=TextEditingController();


  Widget ProfileTextField(String title,TextEditingController controller,String label){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          fillColor: lightGrey,
          filled: true,
          hintText: title,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: lightGrey,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfffBD57EA)),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfffBD57EA)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  void saveUserData(String fname,String lname,String mail,String mobile,String desc,String linkedin,String whatsapp){
    print(desc);
    ProfileData _profileData=ProfileData();
    _profileData.EditProfileData(fname, lname, mail, mobile, desc, linkedin, whatsapp, context);
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context,listen: false).user;
    fname.text=user.fname;
    lname.text=user.lname;
    email.text=user.email;
    mobile.text=user.mobilenumber;
    description.text=user.description;
    linkedin.text=user.linkedin;
    whatsapp.text=user.whatsapp;
    return  FractionallySizedBox(
      heightFactor: 0.96,
      child: Container(
            // height: 500,
            width: double.infinity,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(child: ProfileTextField(user.fname, fname, 'First Name')),
                          Flexible(child: ProfileTextField(user.lname, lname,'Last Name')),
                        ],
                      ),
                    ),
                    Flexible(child: ProfileTextField(user.email, email,'E-Mail')),
                    Flexible(child: ProfileTextField(user.mobilenumber, mobile,'Mobile')),
                    Flexible(child: ProfileTextField(user.description, description,'Description')),
                    Flexible(child: ProfileTextField(user.linkedin, linkedin,'Linkedin URL')),
                    Flexible(child: ProfileTextField(user.whatsapp, whatsapp,'Whatsapp URL')),
                    Align(child: Container(height:40,width: 150,child: customButton(title: 'Save', ontap: (){
                      saveUserData(fname.text, lname.text, email.text, mobile.text, description.text, linkedin.text, whatsapp.text);
                      Navigator.pop(context);

                      
                    }))),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
    );
  }
}