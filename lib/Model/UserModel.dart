class UserModel {
  String phoneNumber = '';
  String uid = '';
  String userName = '';
  String imgUrl = '';
  String deviceToken = '';
  List<String> followers = [];
  List<String> following = [];
  List<String> posts = [];

  UserModel({
      required  this.phoneNumber,
      required  this.uid,
      required  this.userName,
      required  this.imgUrl,
      required  this.followers,
      required  this.following,
      required  this.deviceToken,
      required  this.posts
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    uid = json['uid'];
    userName = json['user_name'];
    imgUrl = json['img_url'];

    if(json['followers']!=null && json['followers'].isNotEmpty){
      for(var i in json['followers']){
        followers.add(i);
      }
    }
    if(json['posts']!=null && json['posts'].isNotEmpty){
      for(var i in json['posts']){
        posts.add(i);
      }
    }
    if(json['following']!=null && json['following'].isNotEmpty){
      for(var i in json['following']){
        following.add(i);
      }
    }
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['phone_number'] = phoneNumber;
    data['uid'] = uid;
    data['user_name'] = userName;
    data['followers'] = followers;
    data['following'] = following;
    data['img_url'] = imgUrl;
    data['posts'] = posts;
    data['device_token'] = deviceToken;
    return data;
  }
}
