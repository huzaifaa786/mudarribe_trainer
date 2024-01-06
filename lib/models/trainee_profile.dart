class TraineeProfile {
  late String id;
  late String userType;
  String? name;
  String? email;
  // String? imageUrl;
  String? firebaseToken;
  TraineeProfile(
      {required this.id,
      this.name,
      this.email,
      required this.userType,
      this.firebaseToken});

  TraineeProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
    firebaseToken = json['firebaseToken'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userType'] = this.userType;

    return data;
  }

  factory TraineeProfile.fromMap(Map<String, dynamic> map) {
    return TraineeProfile(
      id: map['id'],
      userType: map['userType'],
      name: map['name'],
      email: map['email'],
      firebaseToken: map['firebaseToken'],
    );
  }
}
