class HospitalEntity {
  String hospitalName;
  int uniqueID;
  String pinCode;
  String paymentType;
  String address;
  String mapLink;
  String phoneNumber;
  int lastUpdatedTimestamp;
  List<Resource> resourcesList;

  HospitalEntity(
      {this.hospitalName,
        this.lastUpdatedTimestamp,
        this.resourcesList,
        this.uniqueID,
        this.mapLink,
        this.pinCode,
        this.phoneNumber,
        this.address,
      this.paymentType});
}

class Resource {
  var resourceName;
  int countAvailable;
  String refID;
  String resIcon;
  Resource({this.countAvailable, this.resourceName,this.refID,this.resIcon});
}