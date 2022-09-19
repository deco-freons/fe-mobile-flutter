import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_list_model.dart';
import 'package:flutter_boilerplate/common/data/brisbane_location_model.dart';
import 'package:flutter_boilerplate/common/data/search_location_response_model.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_geocoding/google_geocoding.dart' as geocode;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gmweb;
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchLocation extends StatefulWidget {
  final String initialSuburb;

  const SearchLocation({Key? key, this.initialSuburb = ""}) : super(key: key);
  static const routeName = '/search-location';

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

final googleApiKey = dotenv.env['googleApiKey'];
final homeScaffoldKey = GlobalKey<ScaffoldState>();
var googleGeocoding = geocode.GoogleGeocoding(googleApiKey!);

class _SearchLocationState extends State<SearchLocation> {
  CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(-27.496987795739493, 153.01530601534353), zoom: 14.0);
  Set<Marker> markerList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  final TextEditingController searchController = TextEditingController();
  late Future<String> _brisbaneLocationJson;
  late BrisbaneLocationListModel _brisbaneLocationList;
  int pickedSuburbId = 0;
  String pickedSuburb = "";
  String pickedCity = "";

  double? lat = 0;
  double? lng = 0;

  @override
  void initState() {
    super.initState();
    _brisbaneLocationJson = getJson();
  }

  Future<String> getJson() async {
    Future<String> jsonData = DefaultAssetBundle.of(context)
        .loadString("lib/common/assets/files/express_public_location.json");
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: homeScaffoldKey,
        body: FutureBuilder<String>(
          future: _brisbaneLocationJson,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              List<dynamic> jsonResult = jsonDecode(snapshot.data!);
              List<BrisbaneLocationModel> locations = jsonResult
                  .map((item) => BrisbaneLocationModel(
                      location_id: item["location_id"],
                      suburb: item["suburb"],
                      city: item["city"],
                      state: item["state"],
                      country: item["country"]))
                  .toList();
              _brisbaneLocationList =
                  BrisbaneLocationListModel(brisbaneLocations: locations);
              if (widget.initialSuburb != "") {
                pickedSuburbId = _brisbaneLocationList.getIdFromSuburb(
                    widget.initialSuburb, widget.initialSuburb);
              }
              return Stack(children: [
                GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                  markers: markerList,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                  onTap: (latlng) async {
                    _handleTap(latlng);
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          controller: searchController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: primary.shade500, width: 5),
                            ),
                            filled: true,
                            fillColor: primary.shade400,
                            suffixIcon: const Icon(Icons.search_outlined),
                          ),
                          onTap: _handlePressButton,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (searchController.text != "") {
                                Navigator.pop(
                                    context,
                                    SearchLocationResponseModel(
                                      searchController.text.split(",")[0],
                                      lat!,
                                      lng!,
                                      pickedSuburbId,
                                      pickedSuburb,
                                      pickedCity,
                                    ));
                              }
                            },
                            child: const Text("Select")),
                      ],
                    ),
                  ),
                ),
              ]);
            } else {
              return const Text("Loading...");
            }
          },
        ));
  }

  Future<void> _handleTap(LatLng latlng) async {
    geocode.GeocodingResponse? response = await googleGeocoding.geocoding
        .getReverse(geocode.LatLon(latlng.latitude, latlng.longitude));
    if (response != null && response.results != null) {
      geocode.GeocodingResult place = response.results![0];
      String placeName = place.formattedAddress!;

      lat = place.geometry?.location?.lat;
      lng = place.geometry?.location?.lng;

      markerList.clear();

      if (lat != null || lng != null) {
        markerList.add(Marker(
            markerId: const MarkerId("0"),
            position: LatLng(lat!, lng!),
            infoWindow: InfoWindow(title: placeName)));
        setState(() {});
      }

      searchController.text = placeName;
      place.addressComponents?.forEach((element) {
        if (element.types?[0] == "administrative_area_level_2") {
          pickedCity = element.shortName ?? "";
        }
        if (element.types?[0] == "locality") {
          pickedSuburb = element.longName ?? "";
          pickedSuburbId = _brisbaneLocationList.getIdFromSuburb(
              element.longName ?? "", element.shortName ?? "");
        }
      });
    } else {
      markerList.clear();
      setState(() {});
    }
  }

  Future<void> _handlePressButton() async {
    gmweb.Prediction? prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey!,
      onError: (e) {},
      mode: _mode,
      language: 'en',
      strictbounds: false,
      types: [""],
      decoration: InputDecoration(
        hintText: "Search",
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.secondary)),
      ),
      components: [Component(Component.country, "aus")],
    );

    displayPrediction(prediction!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction prediction, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: googleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(prediction.placeId!);

    if (detail.result.geometry != null) {
      lat = detail.result.geometry!.location.lat;
      lng = detail.result.geometry!.location.lng;
      markerList.clear();
      markerList.add(Marker(
          markerId: const MarkerId("0"),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(title: detail.result.name)));

      searchController.text = detail.result.name;
      for (var element in detail.result.addressComponents) {
        if (element.types[0] == "locality") {
          pickedSuburbId = _brisbaneLocationList.getIdFromSuburb(
              element.longName, element.shortName);
        }
      }
      setState(() {});

      googleMapController
          .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat!, lng!), 14.0));
    }
  }
}
