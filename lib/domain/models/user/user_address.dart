class UserAddress {
  UserAddress({
    required this.id,
    required this.name,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.neighborhoodId,
    required this.neighborhoodName,
    required this.streetName,
    required this.homeNumber,
    required this.apartmentNumber,
    required this.state,
    required this.isMain,
    required this.geo,
  });

  int id;
  String name;
  int regionId;
  String regionName;
  int districtId;
  String districtName;
  int neighborhoodId;
  String neighborhoodName;
  String streetName;
  String homeNumber;
  String apartmentNumber;
  int state;
  bool isMain;
  String geo;

  String get fullAddress =>
      '$regionName $districtName $neighborhoodName, $streetName, $homeNumber, $apartmentNumber';
}
