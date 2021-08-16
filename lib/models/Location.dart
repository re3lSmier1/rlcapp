class Location {
  String location_name;
  String location_address;
  String location_country;
  String location_opening_time;
  String location_closing_time;
  int location_latitude;
  int location_longitude;
  int location_id;

  Location(
      this.location_id,
      this.location_name,
      this.location_address,
      this.location_country,
      this.location_opening_time,
      this.location_closing_time,
      this.location_latitude,
      this.location_longitude
      );

  factory Location.fromJson(dynamic json) {
    //print(json);
    return Location(
        json['location_id'] as int,
        json['location_name'] as String,
        json['location_address'] as String,
        json['location_country'] as String,
        json['location_opening_time'] as String,
        json['location_closing_time'] as String,
        json['location_latitude'] as int,
        json['location_longitude'] as int,
    );
  }

  @override
  String toString() {
    return '{ ${this.location_id}, ${this.location_name}, ${this.location_address}, ${this.location_country}, ${this.location_opening_time}, ${this.location_closing_time}, ${this.location_latitude}, ${this.location_longitude}, }';
  }
}