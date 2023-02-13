class PostModel {
  String postId = '';
  String userId = '';
  String userName = '';
  String postUrl = '';
  String postType = '';
  String created = '';
  String likeCount = '';
  String commentsCount = '';
  String caption = '';

  PostModel({
       required this.postId,
       required this.userId,
       required this.userName,
       required this.postUrl,
       required this.postType,
       required this.likeCount,
       required this.commentsCount,
       required this.caption,
       required this.created});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_Id'];
    userId = json['user_id'];
    caption = json['caption'];
    userName = json['user_name'];
    commentsCount = json['commentsCount'];
    postUrl = json['post_url'];
    postType = json['post_type'];
    created = json['created'];
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['post_Id'] = postId;
    data['commentsCount'] = commentsCount;
    data['caption'] = caption;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['post_url'] = postUrl;
    data['post_type'] = postType;
    data['created'] = created;
    data['likeCount'] = likeCount;
    return data;
  }
}
