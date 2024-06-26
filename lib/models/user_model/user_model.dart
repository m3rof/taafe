class UserData {
  String? name;
  String? email;
  String? date;
  String? uId;
  String? gender;
  String? specialty;
  String? title;
  String? description;


  UserData({
    required this.email,
    required this.name,
    required this.date,
    required this.uId,
    required this.gender,
    required this.specialty,
     this.title,
     this.description,
  
  });
  factory UserData.fromJson(json) {
    return UserData(
      email: json?["email"],
      name: json?["name"],
      date: json?["date"],
      uId: json?["uId"],
      gender: json?["gender"],
      specialty: json?["specialty"],
      title: json?["title"],
      description: json?["description"],
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "date": date,
      "uId": uId,
      "gender": gender,
      "specialty": specialty,
      "title": title,
      "description": description,
      
    };
  }
}
