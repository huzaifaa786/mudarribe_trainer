class AppUser {
  late String id;
  late String userType;
  String? name;
  String? email;

  AppUser({required this.id, this.name, this.email, required this.userType});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userType'] = this.userType;

    return data;
  }
}
