class EventOrder {
  late String id;
  String? eventId;
  String? trainerId;
  String? userId;
  String? type;
  int? amount;

  EventOrder({
    required this.id,
    this.trainerId,
    this.eventId,
    this.type,
    this.userId,
    this.amount,
  });

  EventOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainerId = json['trainerId'];
    eventId = json['eventId'];
    userId = json['userId'];
    amount = json['amount'] ?? '';
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['orderId'] = id;
  //   data['trainerId'] = trainerId;
  //   data['planId'] = planId;
  //   data['type'] = type;
  //   data['userId'] = userId;
  //   return data;
  // }
}
