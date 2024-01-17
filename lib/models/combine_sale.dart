import 'package:mudarribe_trainer/models/app_user.dart';
import 'package:mudarribe_trainer/models/event_order.dart';
import 'package:mudarribe_trainer/models/order.dart';

class CombinedSaleData {
  final TrainerOrder trainerOrder;
  final EventOrder eventOrder;

  CombinedSaleData({required this.trainerOrder, required this.eventOrder});
}
