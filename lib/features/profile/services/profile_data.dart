import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:connections/constants/global_variables.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class ProfileData{

  void EditProfileData(String fname,String lname,String mail,String mobile,String desc,String linkedin,String whatsapp,BuildContext context) async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
      try {
        http.Response res=await http.post(Uri.parse('$uri/api/user/editdetails'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'fname':fname,'lname':lname,'email':mail,'mobilenumber':mobile,'description':desc,'linkedin':linkedin,'whatsapp':whatsapp,'contact':mobile,'user_id':userProvider.user.id}));

          httpErrorHandle(response: res, context: context, onSuccess: (){
            showSnackBar(context, 'Profile Update Successfully');
          });
      } catch (e) {
        showSnackBar(context,e.toString());
      }
  }

  void saveProfile(File image,BuildContext context) async{
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic('dtjoiiigz', 'lievwxsp');
      // List<String> imageUrls = [];
      String imgUrl='';
      // for (int i = 0; i < images.length; i++) {
        // CloudinaryResponse res = await cloudinary
        //     .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
      //   imageUrls.add(res.secureUrl);
      // }
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: userProvider.user.fname));
      imgUrl=res.secureUrl;


       http.Response resp=await http.post(Uri.parse('$uri/api/user/profilephotoupdated'),headers:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8','x-auth-token':userProvider.user.token
          },body: jsonEncode({'profile':imgUrl,'user_id':userProvider.user.id}));

          httpErrorHandle(response: resp, context: context, onSuccess: (){
            showSnackBar(context, 'Profile Photo Updated Successfully');
          });


    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }
}