class SettingModel {
  bool likeNoti;
  bool shareNoti;
  bool commentNoti;
  bool postNoti;

  SettingModel(
      {this.likeNoti, this.shareNoti, this.commentNoti, this.postNoti});

  SettingModel.fromJson(Map<String, dynamic> json) {
    likeNoti = json['likeNoti'];
    shareNoti = json['shareNoti'];
    commentNoti = json['commentNoti'];
    postNoti = json['postNoti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likeNoti'] = this.likeNoti ?? false;
    data['shareNoti'] = this.shareNoti ?? true;
    data['commentNoti'] = this.commentNoti ?? true;
    data['postNoti'] = this.postNoti ?? true;
    return data;
  }
}
