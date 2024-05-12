class ChatMessage {
  String? codeBooking;
  String? messageId;
  String? message;

  ChatMessage({
    required this.codeBooking,
    required this.messageId,
    required this.message,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      codeBooking: json['codeBooking'],
      messageId: json['messageId'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codeBooking'] = this.codeBooking;
    data['messageId'] = this.messageId;
    data['message'] = this.message;
    return data;
  }
}
