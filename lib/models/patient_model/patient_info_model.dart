class PatientInfoModel {
  PatientInfoModel({
    required this.id,
    required this.height,
    required this.weight,
    required this.blood,
    required this.martialStatus,
    required this.alcohol,
    required this.drugs,
    required this.religious,
    required this.religion,
  });
  late final int id;
  late final int height;
  late final int weight;
  late final String blood;
  late final String martialStatus;
  late final bool alcohol;
  late final bool drugs;
  late final bool religious;
  late final String religion;

  PatientInfoModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    blood = json['blood'];
    martialStatus = json['martialStatus'];
    alcohol = json['alcohol'];
    drugs = json['drugs'];
    religious = json['religious'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['height'] = height;
    _data['weight'] = weight;
    _data['blood'] = blood;
    _data['martialStatus'] = martialStatus;
    _data['alcohol'] = alcohol;
    _data['drugs'] = drugs;
    _data['religious'] = religious;
    _data['religion'] = religion;
    return _data;
  }
}