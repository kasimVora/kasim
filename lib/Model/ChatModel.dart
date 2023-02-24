import 'package:firebase__test/Model/UserModel.dart';

class ChatModel  {
  String userName = '';
  String message = '';
  DateTime? created;
  String from = '';
  String to = '';
  String type= '';
  String messageId= '';
  List<UserModel> participants = [];

  ChatModel({
       required this.userName,
       required this.message,
       required this.created,
       required this.from,
       required this.participants,
       required this.to,
       required this.messageId,
       required this.type});

  ChatModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    message = json['message'];
    created = DateTime.fromMicrosecondsSinceEpoch(json['created'].microsecondsSinceEpoch);
    from = json['from'];
    to = json['to'];
    type = json['type'];
    messageId = json['imgUrl'];
     if(json['participants']!=null){
       for(var i in json['participants']){
         participants.add(UserModel.fromJson(i));
       }
     }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['message'] = message;
    data['created'] = created;
    data['from'] = from;
    data['to'] = to;
    data['type'] = type;
    data['imgUrl'] = messageId;
    data['participants'] = participants.map((model) => model.toJson()).toList();
    return data;
  }
}
