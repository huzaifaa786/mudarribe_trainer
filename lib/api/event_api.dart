
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/event_data_combined.dart';
import 'package:mudarribe_trainer/models/event_order.dart';
import 'package:mudarribe_trainer/models/trainee_profile.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';

class EventApi {
  static final _firestore = FirebaseFirestore.instance;
  final CollectionReference _trainerEventCollection =
      _firestore.collection("trainer_events");

  Future<void> createEvent(TrainerEvent event) async {
    try {
      await _trainerEventCollection.doc(event.id).set(event.toJson());
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to create event',
        message: e.message,
      );
    }
  }

  Future<List<TrainerEvent>> getTrainerEvents(trainerId) async {
    try {
      final result =
          await _trainerEventCollection.orderBy('id', descending: true).get();

      final events = result.docs
          .map(
            (e) => TrainerEvent.fromJson(e.data()! as Map<String, dynamic>),
          )
          .where((item) => item.trainerId == trainerId)
          .toList();

      return events;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to get events',
        message: e.message,
      );
    }
  }

  static Future<QuerySnapshot> geteventAttendees(eventId) async {
    QuerySnapshot eventSnapshot = await FirebaseFirestore.instance
        .collection('event_attendees')
        .where('eventId', isEqualTo: eventId)
        .get();
    return eventSnapshot;
  }

  Future<bool> deleteEvent(String eventId) async {
    try {
      bool result = false;

      _trainerEventCollection
          .doc(eventId)
          .delete()
          .whenComplete(() => result = true);

      return result;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to delete service',
        message: e.message,
      );
    }
  }

  Future<TrainerEvent> getEvent(String eventId) async {
    try {
      var docSnapshot = await _trainerEventCollection.doc(eventId).get();

      return TrainerEvent.fromJson(docSnapshot.data()! as Map<String, dynamic>);
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to delete service',
        message: e.message,
      );
    }
  }

  Future<bool> closeEvent(String eventId) async {
    try {
      bool result = false;

      _trainerEventCollection.doc(eventId).update({
        "eventStatus": "closed",
      }).whenComplete(() => result = true);

      return result;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to delete service',
        message: e.message,
      );
    }
  }

  Future<bool> updateEventPaymentStatus(String eventId) async {
    try {
      bool result = false;

      await _trainerEventCollection.doc(eventId).update({
        "paymentStatus": "paid",
      }).whenComplete(() => result = true);

      return result;
    } on PlatformException catch (e) {
      throw DatabaseApiException(
        title: 'Failed to delete service',
        message: e.message,
      );
    }
  }

  static Future<List<CombinedEventData>>
      fetchCombinedTrainerNotifications() async {
    final trainerId = FirebaseAuth.instance.currentUser!.uid;

    List<CombinedEventData> combinedData = [];

    QuerySnapshot attendee_docs = await FirebaseFirestore.instance
        .collection('event_attendees')
        .where("trainerId", isEqualTo: trainerId)
        .orderBy('id', descending: true)
        .get();

    List<String> userIds =
        attendee_docs.docs.map((doc) => doc['userId'] as String).toList();

    Map<String, TraineeProfile> usersMap = {};

    await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: userIds)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        usersMap[doc.id] =
            TraineeProfile.fromJson(doc.data() as Map<String, dynamic>);
      });
    });
    
    List<String> eventIds =
        attendee_docs.docs.map((doc) => doc['eventId'] as String).toList();

        
    Map<String, TrainerEvent> eventsMap = {};

    await FirebaseFirestore.instance
        .collection('trainer_events')
        .where(FieldPath.documentId, whereIn: eventIds)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        eventsMap[doc.id] =
            TrainerEvent.fromJson(doc.data() as Map<String, dynamic>);
      });
    });

    combinedData = attendee_docs.docs.map((attendeeDoc) {
      final attendeeData = attendeeDoc.data() as Map<String, dynamic>;
      final event_order = EventOrder.fromJson(attendeeData);

      final userId = attendeeDoc['userId'];
      final trainee = usersMap[userId]!;

      final eventId = attendeeDoc['eventId'];
      final event = eventsMap[eventId]!;

      return CombinedEventData(
        trainee: trainee,
        event: event,
        event_order: event_order
      );
    }).toList();

    return combinedData;
  }
}
