class getDistrict {
  String? dISTRICTID;
  String? dISTRICTNAME;
  String? sTATEID;

  getDistrict({this.dISTRICTID, this.dISTRICTNAME, this.sTATEID});

  getDistrict.fromJson(Map<String, dynamic> json) {
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
