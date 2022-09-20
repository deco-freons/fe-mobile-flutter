import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_model.dart';

class BrisbaneLocationUtil {
  static Future<String> getJson(BuildContext context) async {
    return DefaultAssetBundle.of(context)
        .loadString("lib/common/assets/files/express_public_location.json");
  }

  static List<BrisbaneLocationModel> createModel(List<dynamic> data) {
    List<BrisbaneLocationModel> locations = data
        .map((item) => BrisbaneLocationModel(
            location_id: item["location_id"],
            suburb: item["suburb"],
            city: item["city"],
            state: item["state"],
            country: item["country"]))
        .toList();

    return locations;
  }
}
