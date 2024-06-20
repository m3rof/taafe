class NotificationModel {
  static String collectionName = 'notification';
  String category;
  int counter;

  // String date;
  String header;
  bool seen;
  String side;
  String text;
  int userID;

  NotificationModel(
      {required this.category,
      required this.counter,
      // required this.date,
      required this.header,
      required this.seen,
      required this.side,
      required this.text,
      required this.userID});

  NotificationModel.fromjson(Map<String, dynamic> json)
      : this(
          category: json['category'] as String,
          counter: json['counter'] as int,
          // date: json['date'] as String,
          header: json['header'] as String,
          seen: json['seen'] as bool,
          side: json['side'] as String,
          text: json['text'] as String,
          userID: json['userID'] as int,
        );

  Map<String, dynamic> tojson() {
    return {
      'category': category,
      'counter': counter,
      // 'date': date,
      'header': header,
      'seen': seen,
      'side': side,
      'text': text,
      'userID': userID,
    };
  }
}
