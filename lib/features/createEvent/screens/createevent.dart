import 'dart:io';

import 'package:connections/common/widgets/bottom_navigation.dart';
import 'package:connections/common/widgets/common_button.dart';
import 'package:connections/common/widgets/textform.dart';
import 'package:connections/constants/colors.dart';
import 'package:connections/constants/http_error_handle.dart';
import 'package:connections/features/createEvent/services/event.dart';
import 'package:connections/features/home/screens/home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();
  final TextEditingController _eventCityController = TextEditingController();
  final TextEditingController _eventAddressController = TextEditingController();
  final TextEditingController _eventNumberController = TextEditingController();
  final TextEditingController _eventDescController = TextEditingController();
  final _form=GlobalKey<FormState>();
  EventService _eventService=EventService();
File? eventPhoto;

 void selectImages() async {
    var res = await pickImages();
    setState(() {
      eventPhoto = res;
    });
  }

  Future<File> pickImages() async {
  late File images;
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (files != null && files.files != null) {
      images=File(files.files[0].path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}


  void createEvent(){

    try {
       _eventService.createEvent(context, _eventNameController.text.toString(), _eventDateController.text.toString(), _eventTimeController.text.toString(), _eventCityController.text.toString(), _eventAddressController.text.toString(), _eventNumberController.text.toString(),eventPhoto!);
      
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _eventAddressController.dispose();
    _eventCityController.dispose();
    _eventDateController.dispose();
    _eventNumberController.dispose();
    _eventDescController.dispose();
    _eventTimeController.dispose();
    _eventNameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text('Create An Event'),
          actions: [
            Container(
              width: 130,
              height: 40,
              child: customButton(title: 'Post', ontap: () {
                createEvent();
              }),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: (){
                  selectImages();
                },
                child: Container(
                  height: 160,
                  width: double.infinity,
                  color:eventPhoto==null? lightGrey:null,
                  // decoration: BoxDecoration(),
                  child: eventPhoto==null?Icon(Icons.add_a_photo_outlined) :Image.file(eventPhoto!),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      CustomTextFormField(
                          controller: _eventNameController, title: 'Event Name'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          controller: _eventDateController, title: 'Event Date'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          controller: _eventTimeController, title: 'Event Time'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          controller: _eventCityController, title: 'Event City'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          controller: _eventAddressController,
                          title: 'Event Address'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          controller: _eventNumberController,
                          title: 'Event Number'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
