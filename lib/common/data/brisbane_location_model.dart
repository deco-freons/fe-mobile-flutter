import 'package:flutter_boilerplate/common/data/base_model.dart';

class BrisbaneLocationModel extends BaseModel {
  final int locationID;
  final String suburb;
  final String city;
  final String state;
  final String country;

  const BrisbaneLocationModel({
    required this.locationID,
    required this.suburb,
    required this.city,
    required this.state,
    required this.country,
  });

  bool locationFilterBySuburb(String filter) {
    return suburb.toLowerCase().contains(filter.toLowerCase());
  }
}