class UserModel {
  String phoneNumber = '';
  String uid = '';
  String userName = '';
  String imgUrl = '';
  String deviceToken = '';
  List<String> followers = [];
  List<String> following = [];
  List<String> posts = [];
  List<String> savedPosts = [];
  bool isOnline = false;
  String name = '';
  String bio = '';

  UserModel({
      required  this.phoneNumber,
      required  this.uid,
      required  this.userName,
      required  this.imgUrl,
      required  this.followers,
      required  this.following,
      required  this.deviceToken,
      required  this.savedPosts,
      required  this.isOnline,
      required  this.bio,
      required  this.name,
      required  this.posts
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    uid = json['uid'];
    name = json['name']??"";
    bio = json['bio']??"";
    userName = json['user_name'];
    imgUrl = json['img_url'];
    isOnline = json['isOnline'];

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

    if(json['savedPosts']!=null && json['savedPosts'].isNotEmpty){
      for(var i in json['savedPosts']){
        savedPosts.add(i);
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
    data['isOnline'] = isOnline;
    data['posts'] = posts;
    data['device_token'] = deviceToken;
    data['savedPosts'] = savedPosts;
    data['name'] = name;
    data['bio'] = bio;
    return data;
  }
}
