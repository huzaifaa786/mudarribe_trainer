import 'package:mudarribe_trainer/enums/enums.dart';

class TrainerEvent {
  late String id;

  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? price;
  String? capacity;
  String? trainerId;
  String? imageFileName;
  String? imageUrl;
  String? address;
  EventType? eventType;
  PaymentStatus? paymentStatus;
  EventStatus? eventStatus;

  TrainerEvent({
    required this.id,
    this.title,
    this.price,
    this.date,
    this.startTime,
    this.endTime,
    this.trainerId,
    this.capacity,
    this.address,
    this.eventType,
    this.paymentStatus,
    this.eventStatus,
    this.imageFileName,
    this.imageUrl,
  });

  TrainerEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    price = json['price'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    trainerId = json['trainerId'];
    capacity = json['capacity'];
    imageFileName = json['imageFileName'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    eventType = _$enumDecode(_$EventTypeEnumMap, json['eventType']);
    paymentStatus = _$enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']);
    eventStatus = _$enumDecode(_$EventStatusEnumMap, json['eventStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['trainerId'] = trainerId;
    data['title'] = title;
    data['price'] = price;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['capacity'] = capacity;
    data['address'] = address;
    data['imageFileName'] = imageFileName;
    data['imageUrl'] = imageUrl;
    data['eventType'] = _$EventTypeEnumMap[eventType];
    data['paymentStatus'] = _$PaymentStatusEnumMap[paymentStatus];
    data['eventStatus'] = _$EventStatusEnumMap[eventStatus];

    return data;
  }
}

const _$EventTypeEnumMap = {
  EventType.free: 'free',
  EventType.paid: 'paid',
};
const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.paid: 'paid',
};
const _$EventStatusEnumMap = {
  EventStatus.open: 'open',
  EventStatus.closed: 'closed',
};

_$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}
