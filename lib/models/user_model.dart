class UserModel {
  String? uid;
  String? username;
  String? email;
  String? bio;
  List<String>? courses;

  UserModel({this.uid, this.username, this.email, this.bio, this.courses});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    bio = json['bio'];
    courses = json['courses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['courses'] = this.courses;
    return data;
  }
}