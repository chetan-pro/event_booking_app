class PackageModel {
  int? success;
  Data? data;
  String? error;

  PackageModel({this.success, this.data, this.error});

  PackageModel.fromJson(Map<String, dynamic> json) {
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
  List<Packages>? packages;
  UserActivePackage? userActivePackage;

  Data({this.packages, this.userActivePackage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
    userActivePackage = json['user_active_package'] != null
        ? new UserActivePackage.fromJson(json['user_active_package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    if (this.userActivePackage != null) {
      data['user_active_package'] = this.userActivePackage!.toJson();
    }
    return data;
  }
}

class Packages {
  int? id;
  String? title;
  String? features;
  bool? userPackage;

  Packages({this.id, this.title, this.features, this.userPackage});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    features = json['features'];
    userPackage = json['user_package'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['features'] = this.features;
    data['user_package'] = this.userPackage;
    return data;
  }
}

class UserActivePackage {
  dynamic iD;
  String? package;
  String? expirationDate;
  String? total;
  String? status;
  String? renewLink;

  UserActivePackage(
      {this.iD,
      this.package,
      this.expirationDate,
      this.total,
      this.status,
      this.renewLink});

  UserActivePackage.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    package = json['package'];
    expirationDate = json['expiration_date'];
    total = json['total'];
    status = json['status'];
    renewLink = json['renew_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['package'] = this.package;
    data['expiration_date'] = this.expirationDate;
    data['total'] = this.total;
    data['status'] = this.status;
    data['renew_link'] = this.renewLink;
    return data;
  }
}
