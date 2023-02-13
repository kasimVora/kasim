class UserModel {
  String phoneNumber = '';
  String uid = '';
  String userName = '';
  String imgUrl = '';
  String deviceToken = '';

  UserModel({
      required  this.phoneNumber,
      required  this.uid,
      required  this.userName,
      required  this.imgUrl,
      required  this.deviceToken
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    uid = json['uid'];
    userName = json['user_name'];
    imgUrl = json['img_url'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['phone_number'] = phoneNumber;
    data['uid'] = uid;
    data['user_name'] = userName;
    data['img_url'] = imgUrl;
    data['device_token'] = deviceToken;
    return data;
  }
}
