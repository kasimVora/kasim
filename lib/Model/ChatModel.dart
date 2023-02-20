class ChatModel  {
  String userName = '';
  String message = '';
  DateTime? created;
  String from = '';
  String to = '';
  String type= '';
  String imgUrl= '';
  List<String> participants = [];

  ChatModel({
       required this.userName,
       required this.message,
       required this.created,
       required this.from,
       required this.participants,
       required this.to,
       required this.imgUrl,
       required this.type});

  ChatModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    message = json['message'];
    created = DateTime.fromMicrosecondsSinceEpoch(json['created'].microsecondsSinceEpoch);
    from = json['from'];
    to = json['to'];
    type = json['type'];
    imgUrl = json['imgUrl'];
     if(json['participants']!=null){
       for(var i in json['participants']){
         participants.add(i);
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
    data['imgUrl'] = imgUrl;
    data['participants'] = participants;
    return data;
  }
}
