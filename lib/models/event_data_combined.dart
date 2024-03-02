

import 'package:mudarribe_trainer/models/event_order.dart';
import 'package:mudarribe_trainer/models/trainee_profile.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';


class CombinedEventData {
  final TraineeProfile trainee;
  final TrainerEvent event;
  final EventOrder event_order;

  CombinedEventData({
    required this.trainee,
    required this.event,
    required this.event_order,
  });
}
