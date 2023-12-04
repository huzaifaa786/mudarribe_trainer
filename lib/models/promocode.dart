class PromoCode {
  late String id;

  String? name;
  String? discount;

  String? trainerId;

  PromoCode({required this.id, this.name, this.discount, this.trainerId});

  PromoCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainerId = json[trainerId];
    name = json['name'];

    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['trainerId'] = trainerId;
    data['name'] = name;

    data['discount'] = discount;

    return data;
  }
}
