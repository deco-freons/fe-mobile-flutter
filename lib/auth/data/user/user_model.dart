import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/common/bloc/base_state.dart';
import 'package:flutter_boilerplate/common/data/base_model.dart';

class UserModel extends Equatable {
  final String id;
  const UserModel(this.id);

  @override
  List<Object> get props => [id];

  static const empty = UserModel('-');
}
