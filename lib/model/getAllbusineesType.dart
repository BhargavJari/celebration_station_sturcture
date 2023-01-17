class getAllBusinessType {
  int? status;
  String? message;
  List<Users>? users;

  getAllBusinessType({this.status, this.message, this.users});

  getAllBusinessType.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? gASID;
  String? gASTT;
  String? gASNAME;
  String? gASSTATUS;

  Users({this.gASID, this.gASTT, this.gASNAME, this.gASSTATUS});

  Users.fromJson(Map<String, dynamic> json) {
    gASID = json['GAS_ID'];
    gASTT = json['GAS_TT'];
    gASNAME = json['GAS_NAME'];
    gASSTATUS = json['GAS_STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GAS_ID'] = this.gASID;
    data['GAS_TT'] = this.gASTT;
    data['GAS_NAME'] = this.gASNAME;
    data['GAS_STATUS'] = this.gASSTATUS;
    return data;
  }
}
