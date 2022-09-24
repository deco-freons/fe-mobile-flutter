import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/common/network/network_client.dart';

@immutable
abstract class BaseDataProvider {
  final NetworkClient networkClient = NetworkClient();
}
