class UserModel {
  String? uid;
  String? username;
  String? email;
  String? photoUrl;
  UserModel({
    this.uid,
    this.username,
    this.email,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] == null ? '' : json['uid'] as String,
      username: json["username"] == null ? '' : json['username'] as String,
      email: json["email"] == null ? '' : json['email'] as String,
      photoUrl: json["photoUrl"] == null ? '' : json['photoUrl'] as String,
    );
  }
}
