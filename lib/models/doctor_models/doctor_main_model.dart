class DoctorMainModel {
  DoctorMainModel({
    required this.id,
    required this.name,
    required this.title,
    required this.birthDate,
    required this.profileImage,
    required this.gender,
    required this.description,
    required this.language,
    required this.online,
    required this.starRate,
    required this.completedSessions,
    required this.pendingSessions,
    required this.email,
  });
  late final String id;
  late final String name;
  late final String title;
  late final String birthDate;
  late final String profileImage;
  late final String gender;
  late final String description;
  late final String language;
  late final bool online;
  late final int starRate;
  late final int completedSessions;
  late final int pendingSessions;
  late final String email;

  DoctorMainModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    title = json['title'];
    birthDate = json['birthDate'];
    profileImage = json['profileImage'];
    gender = json['gender'];
    description = json['description'];
    language = json['language'];
    online = json['online'];
    starRate = json['starRate'];
    completedSessions = json['completedSessions'];
    pendingSessions = json['pendingSessions'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['title'] = title;
    _data['birthDate'] = birthDate;
    _data['profileImage'] = profileImage;
    _data['gender'] = gender;
    _data['description'] = description;
    _data['language'] = language;
    _data['online'] = online;
    _data['starRate'] = starRate;
    _data['completedSessions'] = completedSessions;
    _data['pendingSessions'] = pendingSessions;
    _data['email'] = email;
    return _data;
  }
}