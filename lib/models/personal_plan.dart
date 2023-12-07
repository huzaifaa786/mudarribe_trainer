class PersonalPlan {
  late String id;

  String? name;
  String? price;

  String? category;
  String? trainerId;

  PersonalPlan(
      {required this.id, this.name, this.price, this.category, this.trainerId});

  PersonalPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainerId = json[trainerId];
    name = json['name'];
    price = json['price'];

    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['trainerId'] = trainerId;
    data['name'] = name;
    data['price'] = price;

    data['category'] = category;

    return data;
  }
}
