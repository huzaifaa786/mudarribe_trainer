// ignore_for_file: prefer_collection_literals
import 'package:mudarribe_trainer/enums/enums.dart';

class TrainerStory {
  late String id;
  String? caption;
  String? trainerId;
  String? imageFileName;
  String? imageUrl;
  String? postedTime;
  MediaType? mediaType;
 
  TrainerStory(
      {required this.id,
   this.caption,this.imageFileName,this.imageUrl,this.trainerId,this.mediaType,this.postedTime});

  TrainerStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caption = json['caption'];
    trainerId = json['trainerId'];
    imageFileName = json['imageFileName'];
    imageUrl = json['imageUrl'];
    postedTime = json['postedTime'];
    mediaType = _$enumDecode(_$StoryMediaTypeEnumMap,json['mediaType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['caption'] = caption;
    data['trainerId'] = trainerId;
    data['imageFileName'] = imageFileName;
    data['imageUrl'] = imageUrl;
    data['postedTime'] = postedTime;
    data['mediaType'] = _$StoryMediaTypeEnumMap[mediaType];

    return data;
  }
}

const _$StoryMediaTypeEnumMap = {
  MediaType.image: 'image',
  MediaType.video: 'video',
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
