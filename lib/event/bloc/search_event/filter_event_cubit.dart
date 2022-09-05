import 'dart:async';

import 'package:flutter_boilerplate/common/bloc/base_cubit.dart';
import 'package:flutter_boilerplate/common/utils/error_handler.dart';
import 'package:flutter_boilerplate/event/bloc/search_event/filter_event_state.dart';

class FilterEventCubit extends BaseCubit<FilterEventState> {
  StreamController<bool> clearController = StreamController<bool>();

  FilterEventCubit() : super(const FilterEventInitialState());

  Future<void> emitClearState() async {
    try {
      emit(const FilterEventClearState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(FilterEventErrorState(errorMessage: message));
    }
  }

  Future<void> emitInitialState() async {
    try {
      emit(const FilterEventInitialState());
    } catch (e) {
      String message = ErrorHandler.handle(e);
      emit(FilterEventErrorState(errorMessage: message));
    }
  }
}
