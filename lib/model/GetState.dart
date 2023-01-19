class getState {
  int? status;
  String? message;
  List<States>? states;

  getState({this.status, this.message, this.states});

  getState.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

  class States {
  String? sTATEID;
  String? sTATENAME;
  String? cOUNTRYID;

  States({this.sTATEID, this.sTATENAME, this.cOUNTRYID});

  States.fromJson(Map<String, dynamic> json) {
    sTATEID = json['STATE_ID'];
    sTATENAME = json['STATE_NAME'];
    cOUNTRYID = json['COUNTRY_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATE_ID'] = this.sTATEID;
    data['STATE_NAME'] = this.sTATENAME;
    data['COUNTRY_ID'] = this.cOUNTRYID;
    return data;
  }
}
