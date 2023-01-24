class EventModel {
  int? status;
  String? message;
  List<Booking>? booking;

  EventModel({this.status, this.message, this.booking});

  EventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['$booking'] != null) {
      booking = <Booking>[];
      json['$booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.booking != null) {
      data['$booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String? cBDID;
  String? cBDTT;
  String? cBDBOOKINGDATE;
  String? cBDLOGINID;
  String? cBDBOOKINGAMOUNT;
  String? cBDBOOKINGADVANCE;
  String? cBDMALENAME;
  String? cBDFEMALENAME;
  String? cBDDESC;
  String? cBDSTATUS;
  String? cBDBOOKINGID;
  String? cBDCUSTOMERCONTACT;
  String? cBDYEAR;
  String? cBDMONTH;
  String? cBDTITLE;
  String? cBBREFERBY;
  String? cBDCANCELLEDREASON;
  String? cBDCANCELLEDBY;

  Booking(
      {this.cBDID,
        this.cBDTT,
        this.cBDBOOKINGDATE,
        this.cBDLOGINID,
        this.cBDBOOKINGAMOUNT,
        this.cBDBOOKINGADVANCE,
        this.cBDMALENAME,
        this.cBDFEMALENAME,
        this.cBDDESC,
        this.cBDSTATUS,
        this.cBDBOOKINGID,
        this.cBDCUSTOMERCONTACT,
        this.cBDYEAR,
        this.cBDMONTH,
        this.cBDTITLE,
        this.cBBREFERBY,
        this.cBDCANCELLEDREASON,
        this.cBDCANCELLEDBY});

  Booking.fromJson(Map<String, dynamic> json) {
    cBDID = json['CBD_ID'];
    cBDTT = json['CBD_TT'];
    cBDBOOKINGDATE = json['CBD_BOOKING_DATE'];
    cBDLOGINID = json['CBD_LOGIN_ID'];
    cBDBOOKINGAMOUNT = json['CBD_BOOKING_AMOUNT'];
    cBDBOOKINGADVANCE = json['CBD_BOOKING_ADVANCE'];
    cBDMALENAME = json['CBD_MALE_NAME'];
    cBDFEMALENAME = json['CBD_FEMALE_NAME'];
    cBDDESC = json['CBD_DESC'];
    cBDSTATUS = json['CBD_STATUS'];
    cBDBOOKINGID = json['CBD_BOOKING_ID'];
    cBDCUSTOMERCONTACT = json['CBD_CUSTOMER_CONTACT'];
    cBDYEAR = json['CBD_YEAR'];
    cBDMONTH = json['CBD_MONTH'];
    cBDTITLE = json['CBD_TITLE'];
    cBBREFERBY = json['CBB_REFER_BY'];
    cBDCANCELLEDREASON = json['CBD_CANCELLED_REASON'];
    cBDCANCELLEDBY = json['CBD_CANCELLED_BY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CBD_ID'] = this.cBDID;
    data['CBD_TT'] = this.cBDTT;
    data['CBD_BOOKING_DATE'] = this.cBDBOOKINGDATE;
    data['CBD_LOGIN_ID'] = this.cBDLOGINID;
    data['CBD_BOOKING_AMOUNT'] = this.cBDBOOKINGAMOUNT;
    data['CBD_BOOKING_ADVANCE'] = this.cBDBOOKINGADVANCE;
    data['CBD_MALE_NAME'] = this.cBDMALENAME;
    data['CBD_FEMALE_NAME'] = this.cBDFEMALENAME;
    data['CBD_DESC'] = this.cBDDESC;
    data['CBD_STATUS'] = this.cBDSTATUS;
    data['CBD_BOOKING_ID'] = this.cBDBOOKINGID;
    data['CBD_CUSTOMER_CONTACT'] = this.cBDCUSTOMERCONTACT;
    data['CBD_YEAR'] = this.cBDYEAR;
    data['CBD_MONTH'] = this.cBDMONTH;
    data['CBD_TITLE'] = this.cBDTITLE;
    data['CBB_REFER_BY'] = this.cBBREFERBY;
    data['CBD_CANCELLED_REASON'] = this.cBDCANCELLEDREASON;
    data['CBD_CANCELLED_BY'] = this.cBDCANCELLEDBY;
    return data;
  }
}
