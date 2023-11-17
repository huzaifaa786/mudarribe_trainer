// ignore_for_file: prefer_collection_literals

class AppUser {
  late String id;
  late String userType;
  String? name;
  String? email;
  String? bio;
  String? gender;
  String? profileImageUrl;
  String? certificateUrl;
  String? passportIdUrl;
  List<String>? categories;
  List<String>? languages;

  AppUser({required this.id, this.name, this.email, required this.userType,this.bio,this.gender,this.profileImageUrl,this.certificateUrl,this.passportIdUrl,this.categories,this.languages});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userType = json['userType'];
    bio = json['bio'];
    gender = json['gender'];
    profileImageUrl = json['profileImageUrl'];
    certificateUrl = json['certificateUrl'];
    passportIdUrl = json['passportIdUrl'];
    categories = json['categories'];
    languages = json['languages'];
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
    data['categories'] = categories;
    data['languages'] = languages;

    return data;
  }
}
