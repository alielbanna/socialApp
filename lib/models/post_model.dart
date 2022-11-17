class PostModel {
  String? name;
  String? uID;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uID,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uID = json['uID'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uID': uID,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
