import 'package:connections/constants/colors.dart';
import 'package:connections/features/GuestAccount/screens/guest_profile.dart';
import 'package:connections/features/createEvent/services/event.dart';
import 'package:connections/models/eventModel.dart';
import 'package:connections/provider/event_provider.dart';
import 'package:connections/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/common_button.dart';

class EventAttendees extends StatefulWidget {
  static const routeName = '/event-attendees';
  final EventModel event;
  const EventAttendees({super.key, required this.event});

  @override
  State<EventAttendees> createState() => _EventAttendeesState();
}

class _EventAttendeesState extends State<EventAttendees> {
  EventService _eventService = EventService();
  bool attendingEvent = false;
  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final EventModel _eventModel = eventProvider.events
        .where((event) => event.ename == widget.event.ename)
        .first;
    for(int i=0;i<_eventModel!.eguests.length;i++){
      if(_eventModel.eguests[i].fname==userProvider.user.fname){
          attendingEvent=true;
          break;
      }
    }
    void addUserToEvent() {
      _eventService.addUserEvent(context: context, eventModel: widget.event);
    }
    void removeUserFromEvent() {
      _eventService.removeUserFromEvent(context: context, eventModel: widget.event);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.ename),
        elevation: 3,
        actions: [
          attendingEvent
              ? Container(
                  width: 170,
                  height: 40,
                  child: customButton(
                    title: 'Attending',
                    ontap: () {
                      removeUserFromEvent();
                      setState(() {
                        attendingEvent = false;
                      });
                    },
                    color: buttonTextColor,
                    fontcolor: cardColor,
                  ),
                )
              : Container(
                  width: 170,
                  height: 40,
                  child: customButton(
                      title: 'Attend Event',
                      ontap: () {
                        addUserToEvent();
                        setState(() {
                          attendingEvent = true;
                        });
                      }),
                ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 220,
              color: lightGrey,
              child: Center(child: Text('Image Preview of the event')),
            ),
          ),
          Text('Event Attendees', style: GoogleFonts.aBeeZee(fontSize: 24)),
          if(attendingEvent)
          ListTile(
                        tileColor: backgroundColor,
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.account_circle,
                            size: 45,
                          ),
                        ),
                        title: Text('You',
                            style: GoogleFonts.aBeeZee(fontSize: 20)),
                      ),
          Expanded(
              child: ListView.builder(
                  itemCount: _eventModel.eguests.length,
                  itemBuilder: (context, index) {
                      if(_eventModel.eguests[index].fname==userProvider.user.fname){
                        return null;
                      }
                      

                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ListTile(
                        tileColor: backgroundColor,
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.account_circle,
                            size: 45,
                          ),
                        ),
                        title: Text(_eventModel.eguests[index].fname,
                            style: GoogleFonts.aBeeZee(fontSize: 20)),
                            trailing: Container(height:30,width: 130,child: customButton(title: 'Follow', ontap: (){
                              Navigator.pushNamed(context, GuestProfile.routeName,arguments: _eventModel.eguests[index]);
                            })),
                      ),
                    );
                    
                  }))
        ],
      ),
    );
  }
}
