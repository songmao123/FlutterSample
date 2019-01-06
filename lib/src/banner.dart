class BannerData {
  int errorCode;
  String errorMsg;
  List<BannerItem> data;

  BannerData({this.errorCode, this.data, this.errorMsg});

  factory BannerData.fromJson(Map<String, dynamic> jsonStr) {
    var list = jsonStr['data'] as List;
    print('List type: ${list.runtimeType}');
    List<BannerItem> itemList =
        list.map((i) => BannerItem.fromJson(i)).toList();

    return BannerData(
        errorCode: jsonStr['errorCode'],
        errorMsg: jsonStr['errorMsg'],
        data: itemList);
  }
}

class BannerItem {
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  BannerItem(
      {this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      courseId: json['courseId'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      parentChapterId: json['parentChapterId'],
      userControlSetTop: json['userControlSetTop'],
      visible: json['visible'],
    );
  }
}
