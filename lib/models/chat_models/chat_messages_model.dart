class ChatMessgesModel{
  static String collectionName = 'chatMessages';
  bool seen;
  String senderSide;
  String text;

  ChatMessgesModel(
      {required this.seen,
        required this.text,
        // required this.date,
        required this.senderSide,
        });

  ChatMessgesModel.fromjson(Map<String, dynamic> json)
      : this(
    seen: json['seen'] as bool,
    senderSide: json['senderSide'] as String,
    // date: json['date'] as String,
    text: json['text'] as String,

  );

  Map<String, dynamic> tojson() {
    return {
      'seen': seen,
      'senderSide': senderSide,
      // 'date': date,
      'text': text,

    };
  }
}
