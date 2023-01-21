class faqModel {
  int? status;
  String? message;
  List<Fquestion>? fquestion;

  faqModel({this.status, this.message, this.fquestion});

  faqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['fquestion'] != null) {
      fquestion = <Fquestion>[];
      json['fquestion'].forEach((v) {
        fquestion!.add(new Fquestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.fquestion != null) {
      data['fquestion'] = this.fquestion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fquestion {
  String? fQUESTIONID;
  String? fQUESTIONTT;
  String? fQUESTION;
  String? fANSWER;
  String? fSTATUS;
  String? fQUESTIONTYPE;

  Fquestion(
      {this.fQUESTIONID,
        this.fQUESTIONTT,
        this.fQUESTION,
        this.fANSWER,
        this.fSTATUS,
        this.fQUESTIONTYPE});

  Fquestion.fromJson(Map<String, dynamic> json) {
    fQUESTIONID = json['FQUESTION_ID'];
    fQUESTIONTT = json['FQUESTION_TT'];
    fQUESTION = json['FQUESTION'];
    fANSWER = json['FANSWER'];
    fSTATUS = json['FSTATUS'];
    fQUESTIONTYPE = json['FQUESTION_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FQUESTION_ID'] = this.fQUESTIONID;
    data['FQUESTION_TT'] = this.fQUESTIONTT;
    data['FQUESTION'] = this.fQUESTION;
    data['FANSWER'] = this.fANSWER;
    data['FSTATUS'] = this.fSTATUS;
    data['FQUESTION_TYPE'] = this.fQUESTIONTYPE;
    return data;
  }
}
