// ignore_for_file: prefer_collection_literals
import 'package:get/get.dart';
import 'package:mudarribe_trainer/enums/enums.dart';

class AppUserTransalted {
  late String id;
  late String userType;
  String? name;
  String? email;
  String? bio;
  String? gender;
  String? profileImageFileName;
  String? profileImageUrl;
  String? certificateFileName;
  String? certificateUrl;
  String? passportIdFileName;
  String? passportIdUrl;
  TrainerStatus? status;
  List<String>? categories;
  List<String>? languages;
  String? firebaseToken;
  AppUserTransalted(
      {required this.id,
      this.name,
      this.email,
      required this.userType,
      this.bio,
      this.gender,
      this.profileImageFileName,
      this.profileImageUrl,
      this.certificateFileName,
      this.passportIdFileName,
      this.certificateUrl,
      this.passportIdUrl,
      this.categories,
      this.languages,
      this.firebaseToken,
      this.status});

  AppUserTransalted.fromJson(Map<String, dynamic> json) {
        List<dynamic> translatedCategories = [];

    if (json['categories'] != null) {
      List<dynamic> arabicCategories = List<String>.from(json['categories']);
      for (String category in arabicCategories) {
        var i = category.tr;
        translatedCategories.add(i);
      }
    }
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
    bio = json['bio'];
    gender = json['gender'];
    profileImageFileName = json['profileImageFileName'];
    profileImageUrl = json['profileImageUrl'];
    certificateUrl = json['certificateFileName'];
    certificateUrl = json['certificateUrl'];
    passportIdUrl = json['passportIdFileName'];
    passportIdUrl = json['passportIdUrl'];
    firebaseToken = json['firebaseToken'] ?? '';
    categories = translatedCategories.cast<String>();
    languages = json['languages'].cast<String>();
    status = _$enumDecode(_$TrainerStatusEnumMap, json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['userType'] = userType;
    data['bio'] = bio;
    data['gender'] = gender;
    data['profileImageUrl'] = profileImageUrl;
    data['certificateUrl'] = certificateUrl;
    data['passportIdUrl'] = passportIdUrl;
    data['profileImageFileName'] = profileImageFileName;
    data['certificateFileName'] = certificateFileName;
    data['passportIdFileName'] = passportIdFileName;
    data['categories'] = categories;
    data['firebaseToken'] = this.firebaseToken;
    data['languages'] = languages;
    data['status'] = _$TrainerStatusEnumMap[status];

    return data;
  }
}

const _$TrainerStatusEnumMap = {
  TrainerStatus.pending: 1,
  TrainerStatus.approved: 2,
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
