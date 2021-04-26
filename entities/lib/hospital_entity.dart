class HospitalEntity {
  String hospitalName;
  String city;
  String pinCode;
  String mapLink;
  String phoneNumber;
  int lastUpdatedTimestamp;
  List<Resource> resourcesList;

  HospitalEntity(
      {this.hospitalName,
        this.lastUpdatedTimestamp,
        this.resourcesList,
        this.city,
        this.mapLink,
        this.pinCode,
        this.phoneNumber});
}

class Resource {
  String resourceName;
  int countAvailable;

  Resource(this.countAvailable, this.resourceName);
}