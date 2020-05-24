class TravelTabModel {
  String url;
  List<TravelTabs> tabs;
  Map params;

  TravelTabModel({this.url, this.tabs});

  TravelTabModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    params = json['params'];
    if (json['tabs'] != null) {
      tabs = new List<TravelTabs>();
      json['tabs'].forEach((v) {
        tabs.add(new TravelTabs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelTabs {
  String labelName;
  String groupChannelCode;

  TravelTabs({this.labelName, this.groupChannelCode});

  TravelTabs.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}
