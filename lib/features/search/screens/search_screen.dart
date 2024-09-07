import 'package:connections/constants/colors.dart';
import 'package:connections/features/createEvent/screens/attend_event.dart';
import 'package:connections/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
 static const routeName='/search-screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
  TextEditingController _searchEventController=TextEditingController();
  var search="";
  @override
  Widget build(BuildContext context) {
    final eventProvider=Provider.of<EventProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search For Events'),

      ),

      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: TextFormField(controller: _searchEventController,decoration: InputDecoration(hintText: 'Enter Event Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.black))),onChanged: (val){
            
            setState(() {
              search=val;
              
            });
          },),
        ),
        SizedBox(height: 10,),
        Expanded(child: ListView.builder(itemCount: eventProvider.events.length,itemBuilder:(context,index){
          print(search);
          var eventName=eventProvider.events[index].ename;
          var eventDetail=eventProvider.events[index];
          if(eventName.toLowerCase().contains(search.toLowerCase()))
          {return Padding(
            
            padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
            child: ListTile(onTap: () {
              Navigator.pushNamed(context, EventAttendees.routeName,arguments: eventDetail);
            },tileColor: backgroundColor,leading: CircleAvatar(),title: Text(eventName,style: TextStyle(color: buttonTextColor),),subtitle: Text(eventDetail.eaddress),trailing: Icon(Icons.arrow_forward_ios_rounded,color: buttonColor,),shape: RoundedRectangleBorder(side: BorderSide(color: cardColor)),)
          );}
        }))
      ],),

    );
  }
}