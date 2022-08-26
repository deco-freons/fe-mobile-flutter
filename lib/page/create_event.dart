import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/common/components/forms/custom_form_input_class.dart';
import 'package:flutter_boilerplate/common/components/forms/form_component.dart';
import 'package:flutter_boilerplate/common/config/theme.dart';
import 'package:flutter_boilerplate/preference/data/preference_repository.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_geocoding/google_geocoding.dart' as geocode;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as gmweb;
import 'package:google_maps_webservice/places.dart';
import '../../common/config/enum.dart';
import '../preference/bloc/preference_cubit.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);
  static const routeName = '/create-event';

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PreferenceCubit(PreferenceRepositoryImpl()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: SafeArea(child: buildCreateEvent()),
        ),
      ),
    );
  }

  Widget buildCreateEvent() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Text(
                'Create Event',
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const CreateEventForm(),

        // BlocConsumer<PreferenceCubit, PreferenceState>(
        //   builder: (context, state) {
        //     if (state is PreferenceLoadingState) {
        //       return Center(
        //         child: CircularProgressIndicator(
        //           color: Theme.of(context).colorScheme.secondary,
        //         ),
        //       );
        //     } else if (state is PreferenceErrorState) {
        //       return PreferenceForm(errorMessage: state.errorMessage);
        //     } else {
        //       return const PreferenceForm();
        //     }
        //   },
        //   listener: (context, state) {
        //     if (state is PreferenceSuccessState) {
        //       Navigator.pushNamed(context, Homepage.routeName);
        //     }
        //   },
        // ),
      ],
    );
  }
}

class CreateEventForm extends StatefulWidget {
  final String errorMessage;

  const CreateEventForm({
    Key? key,
    this.errorMessage = "",
  }) : super(key: key);

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  double lat = 0;
  double lng = 0;

  void setLatLng(double lat, double lng) {
    setState(() {
      lat = lat;
      lng = lng;
    });
  }

  final CustomFormInput eventName =
      CustomFormInput(label: 'Event Name', type: TextFieldType.string);

  final CustomFormInput category = CustomFormInput(
    label: 'Category',
    type: TextFieldType.category,
  );

  final CustomFormInput date = CustomFormInput(
    label: 'Date',
    type: TextFieldType.date,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );

  final CustomFormInput eventTime = CustomFormInput(
    label: 'Start and End Time',
    type: TextFieldType.eventTime,
  );

  final CustomFormInput description = CustomFormInput(
    label: 'Description',
    type: TextFieldType.textArea,
  );

  @override
  Widget build(BuildContext context) {
    final CustomFormInput location = CustomFormInput(
      label: 'Location',
      type: TextFieldType.location,
    );

    return CustomForm(
      inputs: [eventName, category, date, eventTime, location, description],
      submitTitle: 'Create',
      submitHandler: () {
        // print(eventName.controller.text);
        // print(category.controller.text);
        // print(date.controller.text);
        // print(eventTime.controller.text);
        // print(eventTime.secondController?.text);
        // print(location.controller.text);
        // print(location.lat);
        // print(location.lng);
        // print(description.controller.text);
      },
      textButtonHandler: () {},
      labelColor: Theme.of(context).colorScheme.tertiary,
      inputStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      errorMessage: widget.errorMessage,
    );
  }
}

// void submit(BuildContext context, List<String> data) {
//   final cubit = context.read<PreferenceCubit>();
//   cubit.setFirstPreference(data);
// }

class Place {
  final String name;
  final double lat;
  final double lng;

  Place(this.name, this.lat, this.lng);
}

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);
  static const routeName = '/search-location';

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

const googleApiKey = 'AIzaSyCqdmcfMfqGHkNWmpm6y02zA_pqZjD6Ccs';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
var googleGeocoding = geocode.GoogleGeocoding(googleApiKey);

class _SearchLocationState extends State<SearchLocation> {
  CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(-27.496987795739493, 153.01530601534353), zoom: 14.0);
  Set<Marker> markerList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  final TextEditingController searchController = TextEditingController();

  double lat = 0;
  double lng = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: Stack(children: [
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
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
            child: TextField(
              controller: searchController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: primary.shade500, width: 5),
                ),
                filled: true,
                fillColor: primary.shade400,
                suffixIcon: const Icon(Icons.search_outlined),
              ),
              onTap: _handlePressButton,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Place(searchController.text, lat, lng));
            },
            child: const Text("Select")),
      ]),
    );
  }

  Future<void> _handleTap(LatLng latlng) async {
    geocode.GeocodingResponse? response = await googleGeocoding.geocoding
        .getReverse(geocode.LatLon(latlng.latitude, latlng.longitude));
    geocode.GeocodingResult? place = response!.results![0];
    String? placeName = place.formattedAddress!;
    lat = place.geometry!.location!.lat!;
    lng = place.geometry!.location!.lng!;

    markerList.clear();
    markerList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: placeName)));

    setState(() {});

    searchController.text = placeName;
  }

  Future<void> _handlePressButton() async {
    gmweb.Prediction? prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: googleApiKey,
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

    lat = detail.result.geometry!.location.lat;
    lng = detail.result.geometry!.location.lng;

    markerList.clear();
    markerList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    searchController.text = detail.result.name;
    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
