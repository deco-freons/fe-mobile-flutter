import 'package:flutter_boilerplate/common/data/base/base_repository.dart';

abstract class EventsHistoryRepository implements BaseRepository {
  Future<void> getEventsHistory();
}

class EventsHistoryRepositoryImpl extends EventsHistoryRepository {
  @override
  Future<void> getEventsHistory() async {}
}
