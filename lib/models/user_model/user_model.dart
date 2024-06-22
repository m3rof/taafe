class UserData {
  String? name;
  String? email;
  String? date;
  String? uId;
  String? gender;


  UserData({
    required this.email,
    required this.name,
    required this.date,
    required this.uId,
    required this.gender,
  
  });
  factory UserData.fromJson(json) {
    return UserData(
      email: json?["email"],
      name: json?["name"],
      date: json?["date"],
      uId: json?["uId"],
      gender: json?["gender"],
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "date": date,
      "uId": uId,
      "gender": gender,
      
    };
  }
}
