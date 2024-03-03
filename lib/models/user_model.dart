class UserModel {
  String? uid;
  String? username;
  String? email;
  String? bio;
  String? photo;
  List<String>? courses;
  List<String>? like_courses;

  UserModel(
      {this.uid,
      this.username,
      this.email,
      this.bio,
      this.courses,
      this.like_courses});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    bio = json['bio'];
    photo = json['photo'];
    courses = json['courses'].cast<String>();
    like_courses = json['like_courses'].cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['photo'] = this.photo;
    data['courses'] = this.courses;
    data['like_courses'] = this.like_courses;
    return data;
  }
}
