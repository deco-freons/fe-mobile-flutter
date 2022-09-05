// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'package:flutter_boilerplate/common/data/base_repository.dart';
import 'package:flutter_boilerplate/common/exception/not_found_exception.dart';
import 'package:flutter_boilerplate/common/utils/secure_storage..dart';
import 'package:flutter_boilerplate/event/data/edit_event_model.dart';
import 'package:flutter_boilerplate/event/data/event_detail_data_provider.dart';
import 'package:flutter_boilerplate/event/data/event_detail_response_model.dart';
import 'package:flutter_boilerplate/event/data/event_participant_model.dart';
import 'package:flutter_boilerplate/get_it.dart';

abstract class EventDetailRepository implements BaseRepository {
  Future<void> getEventDetail(int eventID);
  Future<void> joinEvent(int eventID);
  Future<void> leaveEvent(int eventID);
  Future<void> deleteEvent(int eventID);
  Future<void> editEvent(EventDetailResponseModel updatedModel, int suburbId);
  Stream<EventDetailResponseModel> get data async* {}
  void dispose();
}

class EventDetailRepositoryImpl extends EventDetailRepository {
  final _controller = StreamController<EventDetailResponseModel>();
  final EventDetailDataProvider _eventDetailDataProvider =
      EventDetailDataProvider();
  final _secureStorage = getIt.get<SecureStorage>();
  late EventDetailResponseModel _model;

  @override
  Stream<EventDetailResponseModel> get data async* {
    yield const EventDetailResponseModel.empty();
    yield* _controller.stream;
  }

  @override
  Future<void> getEventDetail(int eventID) async {
    final data = await _eventDetailDataProvider.getEventDetail(eventID);
    EventDetailResponseModel eventDetailResponseModel =
        EventDetailResponseModel.fromJson(data);
    _model = eventDetailResponseModel;
    return _controller.add(eventDetailResponseModel);
  }

  @override
  Future<void> joinEvent(int eventID) async {
    await _eventDetailDataProvider.joinEvent(eventID);
    EventParticipantModel user = await _loadUserFromStorage();

    _model = _model.copyWith(
        event: _model.event.copyWith(
            participated: true,
            participants: _model.event.participants + 1,
            participantList: [..._model.event.participantsList, user]));
    return _controller.add(_model);
  }

  @override
  Future<void> leaveEvent(int eventID) async {
    await _eventDetailDataProvider.leaveEvent(eventID);
    EventParticipantModel user = await _loadUserFromStorage();
    _model = _model.copyWith(
      event: _model.event.copyWith(
        participated: false,
        participants: _model.event.participants - 1,
        participantList: _model.event.participantsList
            .where((participant) => participant.userID != user.userID)
            .toList(),
      ),
    );

    return _controller.add(_model);
  }

  @override
  Future<void> deleteEvent(int eventID) async {
    await _eventDetailDataProvider.deleteEvent(eventID);
    _model = const EventDetailResponseModel.empty();
    return _controller.add(_model);
  }

  @override
  Future<void> editEvent(
      EventDetailResponseModel updatedModel, int suburbId) async {
    EditEventModel requestData = EditEventModel(
        eventID: updatedModel.event.eventID,
        eventName: updatedModel.event.eventName,
        categories: updatedModel.event.categories
            .map((pref) => pref.preferenceID)
            .toList(),
        date: updatedModel.event.date,
        startTime: updatedModel.event.startTime,
        endTime: updatedModel.event.endTime,
        longitude: updatedModel.event.longitude.toString(),
        latitude: updatedModel.event.latitude.toString(),
        location: suburbId,
        locationName: updatedModel.event.locationName,
        shortDescription: updatedModel.event.shortDescription,
        description: updatedModel.event.description);
    await _eventDetailDataProvider.editEvent(requestData);
    return _controller.add(updatedModel);
  }

  @override
  void dispose() => _controller.close();

  Future<EventParticipantModel> _loadUserFromStorage() async {
    String? userString = await _secureStorage.get(key: "user");
    if (userString == null) {
      throw NotFoundException();
    }
    Map<String, dynamic> userMap = jsonDecode(userString);
    EventParticipantModel user = EventParticipantModel.fromJson(userMap);
    return user;
  }
}
