class BlogArticleModel {
  BlogArticleModel({
    required this.id,
    required this.title,
    required this.covorImage,
    required this.mainText,
    required this.edited,
    required this.date,
    required this.views,
    required this.category,
    required this.doctorName,
    required this.doctorTitle,
    required this.doctorProfileImage,
    required this.doctorStarRate,
    required this.doctorSessionNumber,
    required this.images,
    required this.upVotes,
    required this.DoctorUpVotes,
    required this.seen,
    required this.commentsNumber,
  });
  late final int id;
  late final String title;
  late final String covorImage;
  late final String mainText;
  late final int edited;
  late final String date;
  late final int views;
  late final String category;
  late final String doctorName;
  late final String doctorTitle;
  late final String doctorProfileImage;
  late final int doctorStarRate;
  late final int doctorSessionNumber;
  late final List<Images> images;
  late final int upVotes;
  late final int DoctorUpVotes;
  late final int seen;
  late final int commentsNumber;

  BlogArticleModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    covorImage = json['covorImage'];
    mainText = json['mainText'];
    edited = json['edited'];
    date = json['date'];
    views = json['views'];
    category = json['category'];
    doctorName = json['doctorName'];
    doctorTitle = json['doctorTitle'];
    doctorProfileImage = json['doctorProfileImage'];
    doctorStarRate = json['doctorStarRate'];
    doctorSessionNumber = json['doctorSessionNumber'];
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    upVotes = json['upVotes'];
    DoctorUpVotes = json['DoctorUpVotes'];
    seen = json['seen'];
    commentsNumber = json['commentsNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['covorImage'] = covorImage;
    _data['mainText'] = mainText;
    _data['edited'] = edited;
    _data['date'] = date;
    _data['views'] = views;
    _data['category'] = category;
    _data['doctorName'] = doctorName;
    _data['doctorTitle'] = doctorTitle;
    _data['doctorProfileImage'] = doctorProfileImage;
    _data['doctorStarRate'] = doctorStarRate;
    _data['doctorSessionNumber'] = doctorSessionNumber;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['upVotes'] = upVotes;
    _data['DoctorUpVotes'] = DoctorUpVotes;
    _data['seen'] = seen;
    _data['commentsNumber'] = commentsNumber;
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.name,
    required this.link,
  });
  late final int id;
  late final String name;
  late final String link;

  Images.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['link'] = link;
    return _data;
  }
}