class PateintMainModel {
  PateintMainModel({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.profileImage,
    required this.gender,
    required this.language,
    required this.email,
  });
  late final int id;
  late final String name;
  late final String birthDate;
  late final String profileImage;
  late final String gender;
  late final String language;
  late final String email;

  PateintMainModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    birthDate = json['birthDate'];
    profileImage = json['profileImage'];
    gender = json['gender'];
    language = json['language'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['birthDate'] = birthDate;
    _data['profileImage'] = profileImage;
    _data['gender'] = gender;
    _data['language'] = language;
    _data['email'] = email;
    return _data;
  }
}