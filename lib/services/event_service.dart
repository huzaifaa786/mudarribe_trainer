import 'package:mudarribe_trainer/api/event_api.dart';
import 'package:mudarribe_trainer/models/trainer_event.dart';

class EventService {
  final _eventApi = EventApi();

  Future<void> createEvent({required TrainerEvent event}) async {
    await _eventApi.createEvent(event);
  }

  Future<List<TrainerEvent>> getTrainerEvents({required trainerId}) async {

    return await _eventApi.getTrainerEvents(trainerId);
  }
  Future<TrainerEvent> getTrainerEvent({required eventId}) async {

    return await _eventApi.getEvent(eventId);
  }
}
