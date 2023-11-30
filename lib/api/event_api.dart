import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mudarribe_trainer/exceptions/database_api_exception.dart';
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
      final result = await _trainerEventCollection.get();

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
}
