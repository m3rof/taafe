class UserData {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  List? followers;
  List? followings;
  List? posts;
  List? savedPosts;

  UserData({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
    required this.followers,
    required this.followings,
    required this.posts,
    required this.savedPosts,
  });
  factory UserData.fromJson(json) {
    return UserData(
      email: json?["email"],
      name: json?["name"],
      phone: json?["phone"],
      uId: json?["uId"],
      image: json?["image"],
      cover: json?["cover"],
      bio: json?["bio"],
      isEmailVerified: json?["isEmailVerified"],
      followers: json?["followers"],
      followings: json?["followings"],
      posts: json?["posts"],
      savedPosts: json?["saved posts"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "image": image,
      "cover": cover,
      "bio": bio,
      "isEmailVerified": isEmailVerified,
      "followers": followers,
      "followings": followings,
      "posts": posts,
      "saved posts": savedPosts,
    };
  }
}
