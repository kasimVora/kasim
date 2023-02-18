class ChatModel  {
  String messageId = '';
  String message = '';
  DateTime? created;
  String from = '';
  String to = '';
  String type= '';

  ChatModel({
       required this.messageId,
       required this.message,
       required this.created,
       required this.from,
       required this.to,
       required this.type});

  ChatModel.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    message = json['message'];
    created = json['created'];
    from = json['from'];
    to = json['to'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageId'] = messageId;
    data['message'] = message;
    data['created'] = created;
    data['from'] = from;
    data['to'] = to;
    data['type'] = type;
    return data;
  }
}
