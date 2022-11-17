class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uID;
  String? image;
  String? cover;
  String? bio;
  late bool isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uID,
    this.image,
    this.cover,
    this.bio,
    required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uID = json['uID'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uID': uID,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
