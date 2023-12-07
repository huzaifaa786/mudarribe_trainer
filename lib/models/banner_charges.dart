class BannerCharges {
  late String id;
  String? amount;

  BannerCharges({
    required this.id,
    this.amount,
  });

  BannerCharges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['amount'] = amount;
    return data;
  }
}
