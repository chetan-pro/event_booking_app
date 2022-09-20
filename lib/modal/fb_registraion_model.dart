class FBregistration {
  int? success;
  Data? data;
  String? error;

  FBregistration({this.success, this.data, this.error});

  FBregistration.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? userId;
  String? msg;

  Data({this.userId, this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = userId;
    data['msg'] =  msg;
    return data;
  }
}
