class CourseModel {
  String? title;
  String? description;
  List<String>? videos;
  List<String>? files;
  String? thumbnail;
  String? skillGain;
  String? level;
  String? category;
  String? language;
  int? likes;
  String? addedat;
  String? updatedat;

  CourseModel(
      {this.title,
      this.description,
      this.videos,
      this.files,
      this.thumbnail,
      this.skillGain,
      this.level,
      this.category,
      this.language,
      this.likes,
      this.addedat,
      this.updatedat});

  CourseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    videos = json['videos'].cast<String>();
    files = json['files'].cast<String>();
    thumbnail = json['thumbnail'];
    skillGain = json['skillGain'];
    level = json['level'];
    category = json['category'];
    language = json['language'];
    likes = json['likes'];
    addedat = json['addedat'];
    updatedat = json['updatedat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['videos'] = this.videos;
    data['files'] = this.files;
    data['thumbnail'] = this.thumbnail;
    data['skillGain'] = this.skillGain;
    data['level'] = this.level;
    data['category'] = this.category;
    data['language'] = this.language;
    data['likes'] = this.likes;
    data['addedat'] = this.addedat;
    data['updatedat'] = this.updatedat;
    return data;
  }
}
