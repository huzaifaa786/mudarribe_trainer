import 'package:json_annotation/json_annotation.dart';

enum TrainerStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  approved
}