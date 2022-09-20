class DiscountModel {
  int? success;
  Data? data;
  String? error;

  DiscountModel({this.success, this.data, this.error});

  DiscountModel.fromJson(Map<String, dynamic> json) {
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
  String? discountNumber;
  String? discountPercenr;
  String? quantity;
  List<String>? idTicket;

  Data(
      {this.discountNumber,
        this.discountPercenr,
        this.quantity,
        this.idTicket});

  Data.fromJson(Map<String, dynamic> json) {
    discountNumber = json['discount_number'];
    discountPercenr = json['discount_percenr'];
    quantity = json['quantity'];
    idTicket = json['id_ticket'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_number'] = this.discountNumber;
    data['discount_percenr'] = this.discountPercenr;
    data['quantity'] = this.quantity;
    data['id_ticket'] = this.idTicket;
    return data;
  }
}
