import 'dart:io';

import 'package:flutter_boilerplate/common/utils/file_parser.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/create_event_state.dart';
import 'package:flutter_boilerplate/event/data/common/event_image_request_model.dart';
import 'package:flutter_boilerplate/event/data/create_event_model.dart';
import 'package:flutter_boilerplate/event/data/create_event_repository.dart';

class CreateEventCubit extends BaseCubit<CreateEventState> {
  final CreateEventRepository _createEventRepository;

  CreateEventCubit(this._createEventRepository)
      : super(const CreateEventInitialState());

  Future<void> createEvent(CreateEventModel data, File? image) async {
    try {
      emit(const CreateEventLoadingState());
      dynamic response = await _createEventRepository.createEvent(data);
      int eventID = response["eventID"];

      if (image != null) {
        EventImageRequestModel imageData =
            EventImageRequestModel(eventID: eventID, eventImage: image);
        List<String>? mimeType =
            FileParser.getFileMime(imageData.eventImage.path);
        if (mimeType != null) {
          MediaType mediaType = MediaType(mimeType[0], mimeType[1]);
          Map<String, dynamic> req = await imageData.toJson(mediaType);

          await _createEventRepository.uploadImage(req);
        }
      }

      emit(const CreateEventSuccessState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(CreateEventErrorState(errorMessage: message));
    }
  }
}
