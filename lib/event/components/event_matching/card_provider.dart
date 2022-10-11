import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_join_cubit.dart';
import 'package:flutter_boilerplate/event/data/event_matching/event_matching_response_model.dart';

class CardProvider extends ChangeNotifier {
  List<EventMatchingResponseModel> _events = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  EventMatchingJoinCubit? _cubit;
  bool loading = false;

  List<EventMatchingResponseModel> get events => _events;
  bool get isDragging => _isDragging;
  Offset get position => _position;

  CardProvider(EventMatchingJoinCubit cubit) {
    _cubit = cubit;
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void addEvents(List<EventMatchingResponseModel> events) {
    if (!loading) {
      loading = true;
      _events = events;
    }
    loading = false;
  }

  EventMatchingResponseModel getCurrentEvent() {
    return _events.first;
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.join:
        join(_cubit);
        break;
      case CardStatus.skip:
        skip();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;

    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _position.dx;

    const delta = 100;

    if (x >= delta) {
      return CardStatus.join;
    } else if (x <= -delta) {
      return CardStatus.skip;
    }
    return null;
  }

  void join(EventMatchingJoinCubit? cubit) {
    if (!loading) {
      loading = true;
      _position += Offset(2 * _screenSize.width, 0);
      if (cubit != null && events.isNotEmpty) {
        cubit.joinEvent(getCurrentEvent().eventID);
      }
      _nextCard();

      notifyListeners();
    }
  }

  void skip() {
    if (!loading) {
      loading = true;
      _position -= Offset(2 * _screenSize.width, 0);
      _nextCard();

      notifyListeners();
    }
  }

  Future _nextCard() async {
    if (_events.isEmpty) {
      loading = false;
      return;
    }

    await Future.delayed(const Duration(milliseconds: 200));
    if (events.isNotEmpty) {
      _events.removeAt(0);
    }
    resetPosition();
    loading = false;
  }
}
