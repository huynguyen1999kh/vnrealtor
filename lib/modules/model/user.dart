class UserModel {
  String id;
  String uid;
  String name;
  String email;
  String phone;
  String role;
  int reputationScore;
  List<String> friendIds;
  String createdAt;
  String updatedAt;
  String avatar;
  List<String> followerIds;
  List<String> followingIds;

  UserModel(
      {this.id,
      this.uid,
      this.name,
      this.email,
      this.phone,
      this.role,
      this.reputationScore,
      this.friendIds,
      this.createdAt,
      this.updatedAt,
      this.avatar,
      this.followerIds,
      this.followingIds});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    reputationScore = json['reputationScore'];
    friendIds =
        json['friendIds'] != null ? json['friendIds'].cast<String>() : [];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    avatar = json['avatar'];
    followerIds =
        json['followerIds'] != null ? json['followerIds'].cast<String>() : [];
    followingIds =
        json['followingIds'] != null ? json['followingIds'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['reputationScore'] = this.reputationScore;
    data['friendIds'] = this.friendIds;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['followingIds'] = this.followingIds;
    data['followerIds'] = this.followerIds;
    return data;
  }
}
