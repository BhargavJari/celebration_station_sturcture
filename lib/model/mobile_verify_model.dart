class MobileVerifyModel {
  int? status;
  String? message;
  int? count;

  MobileVerifyModel({this.status, this.message, this.count});

  MobileVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    return data;
  }
}
