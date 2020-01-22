class UserDetails {

  String _empId;
  String _firstName;
  String _emailId;
  String _designation;

  UserDetails(this._empId,this._firstName, this._emailId, this._designation);

  UserDetails.map(dynamic obj) {
    this._empId=obj["empId"];
    this._firstName = obj["firstname"];
    this._emailId = obj["emailId"];
    this._designation = obj["designation"];
  }

  String get empId => _empId;
  String get firstName => _firstName;

  String get emailId => _emailId;

  String get designation => _designation;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["empId"] = _empId;
    map["firstname"] = _firstName;
    map["emailId"] = _emailId;
    map["designation"] = _designation;
    return map;
  }

}