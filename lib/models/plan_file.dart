class PlanFile {
  late String id;

  String? planId;
  String? file;
  String? type;

  PlanFile({
    required this.id,
    this.planId,
    this.file,
    this.type,
  });

  PlanFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json[planId];
    type = json['type'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['planId'] = planId;
    data['type'] = type;
    data['file'] = file;

    return data;
  }
}
