import 'package:flutter/material.dart';
import 'package:connections/models/eventModel.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> _events = [];

  List<EventModel> get events => _events;

  void setEvents(List<EventModel> events) {
    _events = events;
    notifyListeners();
  }

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }

  void updateEvent(EventModel updatedEvent) {
    final index = _events.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      _events[index] = updatedEvent;
      notifyListeners();
    }
  }

  void removeEvent(String eventId) {
    _events.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }
}
