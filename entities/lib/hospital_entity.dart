class HospitalEntity {
  String hospitalName;
  int uniqueID;
  String pinCode;
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
        this.phoneNumber});
}

class Resource {
  var resourceName;
  int countAvailable;
  String refID;
  Resource({this.countAvailable, this.resourceName,this.refID});
}