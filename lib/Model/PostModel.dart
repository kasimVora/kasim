class PostModel {
  String postId = '';
  String userId = '';
  String userName = '';
  String postUrl = '';
  String postType = '';
  DateTime? created;
  List likeCount = [];
  List commentsCount = [];
  String caption = '';
  String location = '';

  PostModel(
      {required this.postId,
      required this.userId,
      required this.userName,
      required this.postUrl,
      required this.postType,
      required this.likeCount,
      required this.commentsCount,
      required this.location,
      required this.caption,
      required this.created});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_Id'];
    userId = json['user_id'];
    caption = json['caption'];
    userName = json['user_name'];
    location = json['location'];
    if (json['commentsCount'] != null && json['commentsCount'].isNotEmpty) {
      for (var i in json['commentsCount']) {
        commentsCount.add(i);
      }
    }
    postUrl = json['post_url'];
    postType = json['post_type'];
    created = DateTime.fromMicrosecondsSinceEpoch(json['created']);
    if (json['likeCount'] != null && json['likeCount'].isNotEmpty) {
      for (var i in json['likeCount']) {
        likeCount.add(i);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['post_Id'] = postId;
    data['commentsCount'] = commentsCount;
    data['caption'] = caption;
    data['location'] = location;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['post_url'] = postUrl;
    data['post_type'] = postType;
    data['created'] = created!.microsecondsSinceEpoch;
    data['likeCount'] = likeCount;
    return data;
  }
}

class CommentModel {
  String userName = '';
  String imgUrl = '';
  String userId = '';
  String comment = '';
  String commentId = '';
  DateTime? posted;

  CommentModel({
      required this.userName,
      required this.userId,
      required this.comment,
      required this.imgUrl,
      required this.commentId,
      required this.posted
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userId = json['user_id'];
    comment = json['comment'];
    commentId = json['comment_Id'];
    imgUrl = json['imgUrl'];
    posted =  DateTime.fromMicrosecondsSinceEpoch(json['posted']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['comment_Id'] = commentId;
    data['imgUrl'] = imgUrl;
    data['posted'] = posted!.microsecondsSinceEpoch;
    return data;
  }
}
