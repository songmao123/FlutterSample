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
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerItem(
      {this.desc,
      this.id,
      this.imagePath,
      this.isVisible,
      this.order,
      this.title,
      this.type,
      this.url});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      desc: json['desc'],
      id: json['id'],
      imagePath: json['imagePath'],
      isVisible: json['isVisible'],
      order: json['order'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }
}

