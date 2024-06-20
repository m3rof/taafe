class ChatRoomModel{
  static String collectionName = 'chatRoom';
  String last_d_message;
  int doctorID;
  String doctorName;
  String last_p_message;
  String patientName;
  int patientID;

  ChatRoomModel(
      {required this.last_d_message,
        required this.doctorID,
        // required this.date,
        required this.doctorName,
        required this.last_p_message,
        required this.patientName,
        required this.patientID});

  ChatRoomModel.fromjson(Map<String, dynamic> json)
      : this(
    last_d_message: json['last_d_message'] as String,
    doctorID: json['doctorID'] as int,
    // date: json['date'] as String,
    doctorName: json['doctorName'] as String,
    last_p_message: json['last_p_message'] as String,
    patientName: json['patientName'] as String,
    patientID: json['patientID'] as int,
  );

  Map<String, dynamic> tojson() {
    return {
      'patientID': patientID,
      'patientName': patientName,
      // 'date': date,
      'last_p_message': last_p_message,
      'doctorName': doctorName,
      'doctorID': doctorID,
      'last_d_message': last_d_message,
    };
  }
}
