class LatLng {
  double lat;
  double lng;

  LatLng(this.lat, this.lng);

  LatLng.name(this.lat, this.lng);

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
        json['lat'] == null ? null : json['lat'],
        json['lng'] == null ? null : json['lng'],
      );

  Map<String, dynamic> toJson() => {
        'lat': lat == null ? null : lat,
        'lng': lng == null ? null : lng,
      };
}
