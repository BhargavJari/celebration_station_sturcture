class getDistrict {
  int? status;
  String? message;
  List<District>? district;

  getDistrict({this.status, this.message, this.district});

  getDistrict.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['district'] != null) {
      district = <District>[];
      json['district'].forEach((v) {
        district!.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.district != null) {
      data['district'] = this.district!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  String? dISTRICTID;
  String? dISTRICTNAME;
  String? sTATEID;

  District({this.dISTRICTID, this.dISTRICTNAME, this.sTATEID});

  District.fromJson(Map<String, dynamic> json) {
    dISTRICTID = json['DISTRICT_ID'];
    dISTRICTNAME = json['DISTRICT_NAME'];
    sTATEID = json['STATE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DISTRICT_ID'] = this.dISTRICTID;
    data['DISTRICT_NAME'] = this.dISTRICTNAME;
    data['STATE_ID'] = this.sTATEID;
    return data;
  }
}
