class SearchLocationResponseModel {
  final String name;
  final double lat;
  final double lng;
  final int suburbId;
  final String suburb;
  final String city;

  SearchLocationResponseModel(
      this.name, this.lat, this.lng, this.suburbId, this.suburb, this.city);
}
