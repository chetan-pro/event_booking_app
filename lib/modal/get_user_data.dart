// // To parse this JSON data, do
// //
// //     final getUserData = getUserDataFromJson(jsonString);
//
// import 'dart:convert';
//
// GetUserData getUserDataFromJson(String str) =>
//     GetUserData.fromJson(json.decode(str));
//
// String getUserDataToJson(GetUserData data) => json.encode(data.toJson());
//
// class GetUserData {
//   GetUserData({
//     required this.success,
//     required this.data,
//     required this.error,
//   });
//
//   int success;
//   Data data;
//   dynamic error;
//
//   factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
//         success: json["success"],
//         data: Data.fromJson(json["data"]),
//         error: json["error"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data.toJson(),
//         "error": error,
//       };
// }
//
// class Data {
//   Data(
//       {required this.displayName,
//       required this.authorIdImage,
//       required this.authorImage,
//       required this.authorEmail,
//       required this.userJob,
//       required this.userPhone,
//       required this.userAddress,
//       required this.description,
//       required this.userProfileSocial,
//       required this.userBankOwner,
//       required this.userBankNumber,
//       required this.userBankBranch,
//       required this.userBankRouting,
//       required this.userBankPaypalEmail,
//       required this.userBankStripeAccount,
//       required this.firstName,
//       required this.lastName,
//       required this.userBankName});
//
//   String? displayName;
//   String? firstName;
//   String? lastName;
//   String? authorIdImage;
//   String? authorImage;
//   String? authorEmail;
//   String? userJob;
//   String? userPhone;
//   String? userAddress;
//   String? description;
//   String? userProfileSocial;
//   String? userBankOwner;
//   String? userBankNumber;
//   String? userBankBranch;
//   String? userBankRouting;
//   String? userBankPaypalEmail;
//   String? userBankStripeAccount;
//   String? userBankName;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         displayName: json["display_name"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         authorIdImage: json["author_id_image"],
//         authorImage: json["author_image"],
//         authorEmail: json["author_email"],
//         userJob: json["user_job"],
//         userPhone: json["user_phone"],
//         userAddress: json["user_address"],
//         description: json["description"],
//         userProfileSocial: json["user_profile_social"],
//         userBankOwner: json["user_bank_owner"],
//         userBankNumber: json["user_bank_number"],
//         userBankBranch: json["user_bank_branch"],
//         userBankRouting: json["user_bank_routing"],
//         userBankPaypalEmail: json["user_bank_paypal_email"],
//         userBankStripeAccount: json["user_bank_stripe_account"],
//         userBankName: json["user_bank_name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "display_name": displayName,
//         "first_name": firstName,
//         "last_name": lastName,
//         "author_id_image": authorIdImage,
//         "author_image": authorImage,
//         "author_email": authorEmail,
//         "user_job": userJob,
//         "user_phone": userPhone,
//         "user_address": userAddress,
//         "description": description,
//         "user_profile_social": userProfileSocial,
//         "user_bank_owner": userBankOwner,
//         "user_bank_number": userBankNumber,
//         "user_bank_branch": userBankBranch,
//         "user_bank_routing": userBankRouting,
//         "user_bank_paypal_email": userBankPaypalEmail,
//         "user_bank_stripe_account": userBankStripeAccount,
//         "user_bank_name": userBankName,
//       };
// }

class GetUserData {
  int? success;
  Data? data;
  dynamic error;

  GetUserData({this.success, this.data, this.error});

  GetUserData.fromJson(Map<String, dynamic> json) {
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
  String? displayName;
  String? firstName;
  String? lastName;
  String? authorIdImage;
  String? authorImage;
  String? authorEmail;
  String? userJob;
  String? userPhone;
  String? userAddress;
  String? description;
  String? userProfileSocial;
  String? userBankOwner;
  String? userBankNumber;
  String? userBankBranch;
  String? userBankRouting;
  String? userBankPaypalEmail;
  String? userBankStripeAccount;
  String? userBankName;

  Data(
      {this.displayName,
        this.firstName,
        this.lastName,
        this.authorIdImage,
        this.authorImage,
        this.authorEmail,
        this.userJob,
        this.userPhone,
        this.userAddress,
        this.description,
        this.userProfileSocial,
        this.userBankOwner,
        this.userBankNumber,
        this.userBankBranch,
        this.userBankRouting,
        this.userBankPaypalEmail,
        this.userBankStripeAccount,
        this.userBankName});

  Data.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    authorIdImage = json['author_id_image'];
    authorImage = json['author_image'];
    authorEmail = json['author_email'];
    userJob = json['user_job'];
    userPhone = json['user_phone'];
    userAddress = json['user_address'];
    description = json['description'];
    userProfileSocial = json['user_profile_social'];
    userBankOwner = json['user_bank_owner'];
    userBankNumber = json['user_bank_number'];
    userBankBranch = json['user_bank_branch'];
    userBankRouting = json['user_bank_routing'];
    userBankPaypalEmail = json['user_bank_paypal_email'];
    userBankStripeAccount = json['user_bank_stripe_account'];
    userBankName = json['user_bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['author_id_image'] = this.authorIdImage;
    data['author_image'] = this.authorImage;
    data['author_email'] = this.authorEmail;
    data['user_job'] = this.userJob;
    data['user_phone'] = this.userPhone;
    data['user_address'] = this.userAddress;
    data['description'] = this.description;
    data['user_profile_social'] = this.userProfileSocial;
    data['user_bank_owner'] = this.userBankOwner;
    data['user_bank_number'] = this.userBankNumber;
    data['user_bank_branch'] = this.userBankBranch;
    data['user_bank_routing'] = this.userBankRouting;
    data['user_bank_paypal_email'] = this.userBankPaypalEmail;
    data['user_bank_stripe_account'] = this.userBankStripeAccount;
    data['user_bank_name'] = this.userBankName;
    return data;
  }
}
