class MyActivity {
  int? success;
  List<Data>? data;
  dynamic error;

  MyActivity({this.success, this.data, this.error});

  MyActivity.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? eventId;
  String? title;
  String? status;
  String? statusEvent;
  String? dateTime;
  String? address;
  List<Sales>? sales;
  String? specialLink;

  Data(
      {this.eventId,
      this.title,
      this.status,
      this.statusEvent,
      this.dateTime,
      this.address,
      this.sales,
      this.specialLink});

  Data.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    title = json['title'];
    status = json['status'];
    statusEvent = json['status_event'];
    dateTime = json['date_time'];
    address = json['address'];
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(new Sales.fromJson(v));
      });
    }
    specialLink = json['special_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['status_event'] = this.statusEvent;
    data['date_time'] = this.dateTime;
    data['address'] = this.address;
    if (this.sales != null) {
      data['sales'] = this.sales!.map((v) => v.toJson()).toList();
    }
    data['special_link'] = this.specialLink;
    return data;
  }
}

class Sales {
  String? date;
  String? totalTicketBooking;
  String? percentSaleTicket;
  List<TicketList>? ticketList;

  Sales(
      {this.date,
      this.totalTicketBooking,
      this.percentSaleTicket,
      this.ticketList});

  Sales.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    totalTicketBooking = json['total_ticket_booking'];
    percentSaleTicket = json['percent_sale_ticket'];
    if (json['ticket_list'] != null) {
      ticketList = <TicketList>[];
      json['ticket_list'].forEach((v) {
        ticketList!.add(new TicketList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['total_ticket_booking'] = this.totalTicketBooking;
    data['percent_sale_ticket'] = this.percentSaleTicket;
    if (this.ticketList != null) {
      data['ticket_list'] = this.ticketList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketList {
  String? nameTicket;
  String? numberTicketSale;

  TicketList({this.nameTicket, this.numberTicketSale});

  TicketList.fromJson(Map<String, dynamic> json) {
    nameTicket = json['name_ticket'];
    numberTicketSale = json['number_ticket_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_ticket'] = this.nameTicket;
    data['number_ticket_sale'] = this.numberTicketSale;
    return data;
  }
}
