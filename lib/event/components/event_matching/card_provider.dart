import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/config/enum.dart';
import 'package:flutter_boilerplate/event/bloc/event_matching/event_matching_join_cubit.dart';
import 'package:flutter_boilerplate/event/data/common/popular_event_model.dart';

class CardProvider extends ChangeNotifier {
  List<PopularEventModel> _events = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  EventMatchingJoinCubit? _cubit;

  List<PopularEventModel> get events => _events;
  bool get isDragging => _isDragging;
  Offset get position => _position;

  CardProvider(EventMatchingJoinCubit cubit) {
    _cubit = cubit;
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void addEvents(List<PopularEventModel> events) {
    _events = events;
  }

  PopularEventModel getCurrentEvent() {
    return _events.last;
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
    _position += Offset(2 * _screenSize.width, 0);
    if (cubit != null) {
      cubit.joinEvent(getCurrentEvent().eventID);
    }
    _nextCard();

    notifyListeners();
  }

  void skip() {
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    if (_events.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _events.removeLast();
    resetPosition();
  }
}
